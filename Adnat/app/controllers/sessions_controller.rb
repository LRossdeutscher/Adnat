class SessionsController < ApplicationController
  
    skip_before_action :authorized, only: [:new, :create]

    def new
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
        redirect_to '/', :notice => "Logged out!"
    end
  
    def login
    end
  
    def welcome
        # @organisation = Organisation.new
    end
  
    def overview
        user = User.find(session[:user_id])
    end
end
