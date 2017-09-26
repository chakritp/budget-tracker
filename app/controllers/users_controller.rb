class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = User.new
    render layout: 'welcome'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id # this signs them
      flash[:success] = "Welcome to Pocket Trackr #{@user.first_name}!"
      redirect_to dashboard_path
    else
      flash[:danger] = "Please ensure all fields are filled correctly"
      redirect_to new_user_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
