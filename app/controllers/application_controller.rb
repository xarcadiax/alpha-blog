class ApplicationController < ActionController::Base
  
  helper_method :current_user
  def current_user
    @current_user || User.find(session[:user_id]) if session[:user_id] #Checks if current user exists IF not checks the users table and returns user
  end
  
  helper_method :logged_in?
  def logged_in?
    !!current_user #turns current user into boolean
  end

end
