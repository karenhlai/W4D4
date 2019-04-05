class ApplicationController < ActionController::Base
    def login_user!(user)
        session[:session_token] = user.session_token #is user assigned a session token when they sign up, from where?
        redirect_to user_url(user)
    end

    def logout
        if @current_user
            session[:session_token] = nil
            user.reset_session_token!
            @current_user = nil
        end
    end

    def logged_in?
        # session[:session_token] == user[:session_token]
        !!(current_user)
    end

    #find current_user's session token by looking at User's session_token
    #look at controller's current session's session_token
    def current_user 
        @current_user ||= User.find_by(session_token: session[:session_token])
    end
end
