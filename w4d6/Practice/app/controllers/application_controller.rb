class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
  	return nil unless session[:session_token]
  	@current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
  	!!current_user
  end
end
