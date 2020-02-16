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
        redirect_to '/log_in', :notice => "Logged out!"
    end
  
    def login
    end
  
    def welcome
        @organisation = Organisation.new
        # store the requesting url in the session hash for 
        # when organisation is deleted
        session[:return_to] ||= request.referer
    end
  
    def overview
        @organisation = Organisation.find(current_user.organisation_id)
    end
end
