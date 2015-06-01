class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :require_user, :require_same 
  # use this to expose the methods below to all views and controllers :require_user, :require_same
 
  def current_user
  # if there is a current user rtn that if not then rtn nil
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
 
  def logged_in?
  !!current_user # indicates whether a user is logged in (boolean)
  end
 
  def require_user
  if !logged_in?
  flash[:error] = "You need to be logged in to take that action"
  redirect_to root_path
  end
  end

  def require_same
  if current_user != @user
  flash[:error] = "You are not authorized to take that action."
  redirect_to root_path
  end
  end


  end
