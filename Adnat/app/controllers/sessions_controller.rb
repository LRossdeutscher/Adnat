class SessionsController < ApplicationController
  
    skip_before_action :authorized, only: [:new, :create]

    def new
    end
  
    def create
        user = User.find_by(email_address: params[:email])
        puts user.inspect
  
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to '/welcome'
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
    end
  
    def page_requires_login
    end
end
