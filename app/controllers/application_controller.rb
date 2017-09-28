class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :authenticate
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authenticate
    unless logged_in?
      flash[:danger] = "You have to be logged in to view this page"
      redirect_to login_path
    end
  end

  def redirect_to_dashboard
    redirect_to dashboard_path if logged_in?
  end
end
