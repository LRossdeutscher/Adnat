class SessionsController < ApplicationController
  
    skip_before_action :authorized, only: [:new, :create]

    def new
        if session[:user_id]
            redirect_to root_path
        end
    end
  
    def create
        user = User.find_by(email_address: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            if user.organisation_id == nil
                redirect_to '/welcome'
            else
                redirect_to '/overview'
            end
        else
            flash.now.alert = "Invalid email or password"
            render "new"
        end
    end
  
    def destroy
        session[:user_id] = nil
        redirect_to '/log_in', :notice => "Logged out!"
    end

    def welcome
        if current_user.organisation_id == nil
            @organisation = Organisation.new
        else
            redirect_to overview_path
        end
    end
  
    def overview
        if current_user.organisation_id != nil
            @organisation = Organisation.find(current_user.organisation_id)
        else
            redirect_to welcome_path
        end
    end
end
