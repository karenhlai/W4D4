class SessionsController < ApplicationController 
    #log in and out
    def new
        render :new
    end

    def create #not logging in !
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        
        if @user
            login_user!(@user)
        else
            flash[:errors] = ['Invalid Login']
            redirect_to new_session_url
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
    
end

