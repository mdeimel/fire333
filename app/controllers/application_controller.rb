class ApplicationController < ActionController::Base
  protect_from_forgery

  def loggedin?
    if session[:login_name].nil? || session[:login_name].empty?
      flash[:error] = "You must be logged in to complete this action."
      redirect_to root_path
      return false
    end
    true
  end
end
