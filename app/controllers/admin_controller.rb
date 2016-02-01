class AdminController < ApplicationController
  layout 'admin'
  before_action :require_login
  
  def dashboard
  end
  
  def preview
  end
  
private
  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to log_in_url # halts request cycle
    end
  end
end