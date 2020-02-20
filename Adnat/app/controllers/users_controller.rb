class UsersController < ApplicationController

    skip_before_action :authorized, only: [:new, :create]

    def user_params
        params.require(:user).permit(:email_address, :name, :password, :password_confirmation)
    end

    def new
        # new user instance for the form
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to '/welcome', :notice => "Signed up!"
        else
            @test = "BRUH"
            render "new"
        end
    end

    def edit
        @user = User.find(current_user.id)
    end

    def update
        @user = User.update(current_user.id, user_params)
        if @user.errors.any?
            render "edit"
        else
            if current_user.organisation_id != nil
                redirect_to overview_path
            else
                redirect_to welcome_path
            end
        end
    end

    def join_organisation
        organisation = Organisation.find(params[:id])
        if organisation
            User.update(current_user.id, organisation_id: organisation.id)
            redirect_to overview_path
        end
    end

    def leave_organisation
        User.update(current_user.id, organisation_id: nil)
        redirect_to welcome_path
    end
end
