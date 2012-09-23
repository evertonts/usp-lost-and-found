# encoding: utf-8

class ApplicationController < ActionController::Base
  
  protect_from_forgery
  include SessionsHelper
  
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to :back, :alert => exception.message
    else
      # Adds the protected page to the login url but only if the user is not logged in
      redirect_to user_session_path(:next => request.path)
    end
    
  end
  
  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      store_location = session[:return_to]
      clear_stored_location
      (store_location.nil?) ? "/" : store_location.to_s
    else
      super
    end
  end
  
end  

