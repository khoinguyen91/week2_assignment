class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  def current_user
  	return @current_user if @current_user
  	if session[:user_id] 
  		@current_user = User.find session[:user_id]
  	end
  end
  def sign_in?
    current_user
  end
  def require_login
    redirect_to sign_in_path, flash: {error: 'Login first to see this page.'} unless sign_in?
  end
  def skipped_login
    redirect_to messages_path(recipient_id: session[:user_id]) if sign_in?
  end
end
