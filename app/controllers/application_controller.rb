class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    helper_method :current_user
    helper_method :signed_in
    helper_method :require_login
    around_filter :set_time_zone
    

    def current_user
        return User.find(session[:user_id]) if session[:user_id] else nil
    end

    def signed_in
        return true if session[:user_id] else false    
    end

    def require_login
        if session[:user_id]
            true
        else
            redirect_to login_path
        end 

    end

    def skip_if_logged_in
        if session[:user_id]
            redirect_to events_path
        end
    end

    def set_time_zone(&block)
        time_zone = current_user.try(:time_zone) || 'UTC'
        Time.use_zone(time_zone, &block)
    end
end
