class SessionsController < ApplicationController
  def new
    render layout: 'welcome'
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user and @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome back #{@user.first_name}!"
      redirect_to dashboard_path
    else
      flash[:danger] = "Please ensure all fields are filled correctly"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:danger] = "You have successfully logged out"
    redirect_to root_path
  end
end
