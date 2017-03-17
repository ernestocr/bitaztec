class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Devise
  
  # if user is admin, then go to dashboard  
  def after_sign_in_path_for(user)
    if user.admin?
      admin_path
    else
      session[:previous_url] || orders_path
    end
  end
end
