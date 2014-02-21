class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_charset
  def set_charset
     #@headers["Content-Type"] = "text/html;charset=utf-8"
  end

  protected
  def authenticate_user
    if current_user
      true
    else
      redirect_to(:controller => 'sessions', :action => 'new')
    end
  end
  
  helper_method :current_user
  helper_method :super_user
  helper_method :open_user
  def current_user
    # set current_user by the current user object
    @current_user ||= User.where(id: session[:user_id]).first
  end

  def open_user
    if @current_user.authority == 2
      true
    else
      false
    end
  end 
    
  def super_user
    if @current_user.authority == 1
      true
    else
      false
    end
  end
end
