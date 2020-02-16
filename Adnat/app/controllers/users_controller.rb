class UsersController < ApplicationController

    skip_before_action :authorized, only: [:new, :create]

    def user_params
        params.require(:user).permit(:email_address, :name, :password, :password_confirmation)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to '/welcome', :notice => "Signed up!"
        else
            render "new"
        end
    end

    def update
        User.update(current_user.id, organisation_id: params[:id])
        redirect_to overview_path
    end

    def leave_organisation
        User.update(current_user.id, organisation_id: nil)
        redirect_to welcome_path
    end
end
