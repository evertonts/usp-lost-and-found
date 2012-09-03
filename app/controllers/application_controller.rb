class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to root_url
    else
      # Adds the protected page to the login url but only if the user is not logged in
      redirect_to login_path(:next => request.path)
    end
    
  end
  
  def after_sign_in_path_for(resource_or_scope)
    params[:user]["next"] || super
  end
  
end
