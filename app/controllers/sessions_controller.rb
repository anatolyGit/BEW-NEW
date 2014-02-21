# encoding: utf-8
class SessionsController < ApplicationController
  
  def new
  end
=begin
  Desc: It confirms the user according to the user info  
  Params: login, password  
=end  
  def login
    # pull the user info from the user model with the login params
    user = User.find_by_login(params[:login])
    # Authenciate with password
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:user_login] = user.login
      session[:user_authority] = user.authority
      # redirect to the landing page
      redirect_to "/projects"
    # failed   
    else
      redirect_to login_url, alert: "無効なID、パスワードの組み合わせです。"
    end
  end
=begin
  Desc: It clears all session informations for logout and redirect to the login page     
=end
  def logout
    session[:user_id] = nil
    session[:user_login] = nil
    session[:user_authority] = nil
    redirect_to login_url, alert: "ログアウトしました。"
  end
end
