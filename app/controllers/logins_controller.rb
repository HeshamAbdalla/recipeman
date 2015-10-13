class LoginsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You logged in successfully"
      redirect_to recipes_path
    else
      flash.now[:danger] = "Email/Password is wrong please try again"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You logged out successfully"
    redirect_to root_path
  end
end
