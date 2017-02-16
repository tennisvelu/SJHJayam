class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #skip_before_action :, only: [:show, :index]
  
  before_action :check_session, :except => ["login_page","validate_login"]
  def check_session
   if session[:user_id].blank?
    redirect_to root_path
   end
  end
  

end
