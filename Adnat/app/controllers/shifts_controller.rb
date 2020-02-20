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
        Time.zone.parse(date + " " + time)
    end


    def calc_shift_length(start, finish)
        if start.before? finish
            # day shift
            (finish - start) / 60 / 60
        else
            # overnight shift
            24 - ((start - finish) / 60 / 60)
        end
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
        @names = {}
        @hours_worked = {}
        @shift_costs = {}

        @shifts.each do |shift|
            @names[shift] = User.find(shift.user_id).name
            shift_length = calc_shift_length(shift.start, shift.finish)
            hours_worked = shift_length - Float(shift.break_length) / 60
            shift_cost = hours_worked * @organisation.hourly_rate
            @hours_worked[shift] = hours_worked.round(2)
            @shift_costs[shift] = shift_cost.round(2)
        end
    end
end
