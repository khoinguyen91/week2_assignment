class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  def current_user
  	return nil if !session[:user_id] || !User.where(id: session[:user_id]).presence

    @current_user ||= User.find(session[:user_id])
  end
  def signed_in?
    current_user
  end
  def require_login
    redirect_to sign_in_path, flash: {error: 'Login first to see this page.'} unless signed_in?
  end
  def skipped_login
    redirect_to messages_path(recipient_id: session[:user_id]) if signed_in?
  end
end
