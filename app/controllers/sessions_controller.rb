class SessionsController < ApplicationController

def new
  @user = User.new
end

def create
  @user = User.find_by_email(params[:user][:email])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Logged in!"
  else
    @user ||= User.new
    flash.now.alert = "Invalid email or password"
    render "new"
  end
end

def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => "Logged out!"
end

end
