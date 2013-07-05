class RegisterationsController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_url, :notice => "Signed up!"
      else
        render "new"
      end
  end

  def destroy
    User.destroy(session[:user_id])
    session[:user_id] = nil
    redirect_to root_url, :notice => "You have removed your account, please register again to participate in Event."
  end

end
