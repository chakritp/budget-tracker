class UsersController < ApplicationController
  before_action :authorize_user, only: [:show, :edit, :update, :reset_password, :update_password]

  def show
    @user = current_user
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
      flash[:danger] = email_taken? ? "This email has already been taken. Please input another email." : "Please ensure all fields are filled correctly"
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.first_name = user_params[:first_name]
    @user.last_name = user_params[:last_name]
    @user.email = user_params[:email]
    @user.avatar = user_params[:avatar]
    
    if email_exists_in_db_and_not_mine(@user.email)
      flash[:danger] = "This email has already been taken. Please input another email." 
      redirect_to edit_user_path(@current_user) and return
    end

    if @user.save(validate: false)
      flash[:success] = "Profile successfully updated!"
      redirect_to user_path(@current_user)
    else
      flash[:danger] = email_taken? ? "This email has already been taken. Please input another email." : "Please ensure all fields are filled correctly"
      redirect_to edit_user_path(@current_user)
    end
  end

  def reset_password
    @user = User.find(params[:id])
  end

  def update_password
    @user = User.find(params[:id])

    if user_params[:password].present? && (user_params[:password] == user_params[:password_confirmation])
      @user.password = user_params[:password]
      @user.save(validate: false)
      flash[:success] = "Password successfully updated!"
      redirect_to user_path(@current_user)
    else
      flash[:danger] = "Please make sure that the passwords match and is not blank"
      redirect_to reset_password_user_path(@current_user)
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      session[:user_id] = nil
      flash[:success] = "You have successfully deleted your account"
      redirect_to root_path
    else
      flash[:danger] = "Something went wrong. Please try again"
      redirect_to edit_user_path(@current_user)
    end
  end

  private
  
  def email_taken?
    @user.errors.full_messages.include?("Email has already been taken")
  end

  def email_exists_in_db_and_not_mine(email)
    user = User.find_by(email: email)
    if user.present? && user.id != current_user.id
      return true
    else
      return false
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar)
  end

  def authorize_user
    user = User.find(params[:id])
    unless current_user == user
      flash[:danger] = "You are not authorized to view that page"
      redirect_to dashboard_path
    end
  end
end
