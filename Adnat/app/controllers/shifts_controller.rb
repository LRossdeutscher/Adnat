class ShiftsController < ApplicationController
    def shift_params
        params.require(:shift).permit(:date, :start, :finish, :break_length)
    end

    def index
        @shift = Shift.new
        table_contents
    end

    def create
        date = shift_params[:date]
        start_datetime = combine_date_time(date, shift_params[:start])
        finish_datetime = combine_date_time(date, shift_params[:finish])
        @shift = Shift.create(user_id: current_user.id, start: start_datetime, finish: finish_datetime, break_length: shift_params[:break_length])
        if @shift.save
            redirect_to shifts_path
        else
            table_contents
            render "index"
        end
    end

    def edit
        @shift = Shift.find(params[:id])
    end

    def update
        date = shift_params[:date]
        start_datetime = combine_date_time(date, shift_params[:start])
        finish_datetime = combine_date_time(date, shift_params[:finish])
        @shift = Shift.update(params[:id], start: start_datetime, finish: finish_datetime, break_length: shift_params[:break_length])
        if @shift.errors.any?
            render "edit"
        else
            redirect_to shifts_path
        end
    end

    def destroy
        Shift.destroy(params[:id])
        redirect_to shifts_path
    end

private
    def combine_date_time(date, time)
        # combine a date and time in string format into a DateTime object
        Time.zone.parse(date + " " + time)
    end

    def calc_shift_length(start, finish)
        # Considers overnight shifts
        if start.before? finish
            # same-day shift
            (finish - start) / 60 / 60
        else
            # overnight shift
            (finish.next_day() - start) / 60 / 60
        end
    end

    def calc_shift_cost(start, finish, hours, rate, break_hours)
        sunday_hours = 0
        normal_hours = 0
        # Considers Sunday penalty rates
        if start.before? finish
            # same-day shift
            if start.sunday? 
                sunday_hours = hours
            else 
                normal_hours = hours
            end
        else
            # overnight shift
            actual_finish = finish.next_day() - (60*60*break_hours)
            difference = 0
            if start.sunday? && actual_finish.monday?
                # shift starts sunday and finishes Monday
                difference = (start.seconds_until_end_of_day + 1)/60/60
            elsif start.saturday? && actual_finish.sunday?
                # shift starts Saturday and finishes Sunday
                difference = (actual_finish.seconds_since_midnight)/60/60
            end
            sunday_hours = difference
            normal_hours = hours - difference
        end
        # return shift cost
        return (normal_hours * rate) + (sunday_hours * rate * 2)
    end

    def table_contents
        # set organisations instance variable for the html heading
        @organisation = Organisation.find(current_user.organisation_id)
        # I couldn't figure out how to get Rails to return me a query result
        # that contains a shift record along with just the users.name
        #  
        # Tried different combinations of .joins and .includes as well as
        # changing around the associations of the Shift and User models
        #  
        # Want result typically returned by (or similar to): 
        #   SELECT users.name, shifts.* 
        #   FROM users, shifts
        #   WHERE users.id = shifts.user_id
        #
        # Going to use a rails hash data structure instead.
        @shifts = Shift.includes(:user).where(users: {organisation_id: current_user.organisation_id}).order(created_at: :desc)

        @names = {} # store the User's name of each shift
        @hours_worked = {} # store the hours worked for each shift
        @shift_costs = {} # store the shift cost for each shift

        @shifts.each do |shift|
            @names[shift] = User.find(shift.user_id).name
            shift_length = calc_shift_length(shift.start, shift.finish)
            hours_worked = shift_length - Float(shift.break_length) / 60
            shift_cost = calc_shift_cost(shift.start, shift.finish, hours_worked, @organisation.hourly_rate, Float(shift.break_length)/60)
            #shift_cost = hours_worked * @organisation.hourly_rate
            @hours_worked[shift] = hours_worked.round(2)
            @shift_costs[shift] = shift_cost.round(2)
        end
    end
end
