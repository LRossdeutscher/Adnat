class ApplicationController < ActionController::Base
    before_action :authorized
    helper_method :current_user
    helper_method :logged_in?

    private
    
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !current_user.nil?
    end

    def authorized
        redirect_to '/log_in' if !logged_in?
    end
end
