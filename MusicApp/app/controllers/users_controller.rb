class UsersController < ApplicationController
    #sign up
    def new
        render :new
    end

    def show
        render :show
    end

    def create
        @user = User.new(users_params) 
        
        if @user
            @user.save! #valid input, signed up!
            login_user!(@user)
        else
            flash.now[:errors] = ['Inputs are invalid, sign up again!']
            render :new
        end
    end

    private
    def users_params
        params.require(:user).permit(:email, :password) #where is :password coming from?
    end
end

