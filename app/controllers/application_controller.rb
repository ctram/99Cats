class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user


  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def sign_in(user)
    session[:session_token] = user.reset_session_token!
  end

  def redirect_if_logged_in
    redirect_to cats_url if current_user
  end

  def redirect_unless_logged_in
    redirect_to new_session_url if current_user.nil?
  end
end
