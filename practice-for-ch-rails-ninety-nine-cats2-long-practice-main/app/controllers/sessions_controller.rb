class SessionsController < ApplicationController
    def new
        @user= User.new
    end

    def create
        
        @user = User.find_by_cred(params[:user][:username],params[:user][:password])
        if @user
            login(@user)
            redirect_to cats_url
        else
            redirect_to new_user_url
        end
        
    end

    def destroy 
        logout! 
        redirect_to new_session_url
    end

    private
    def user_params
        params.require(:user).permit(:username,:password)
    end

end
