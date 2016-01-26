class SessionsController < ApplicationController
  ADMIN_LOGIN = "admin@example.com"
  ADMIN_PASS = "pass"
  
  layout false
  
  def new
  end
  
  def create
    params.permit(:login,:password)
    if params[:login] == ADMIN_LOGIN and params[:password] == ADMIN_PASS
      session[:user_id] = params[:login]
      redirect_to admin_dashboard_url
    else
      flash.now.alert = "Invalid login name or password"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end