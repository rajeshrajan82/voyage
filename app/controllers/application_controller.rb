class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, :if => Proc.new { controller_name == "home" || controller_name == "tracking" }
  
  def after_sign_in_path_for(resource)
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
    if request.referer == sign_in_url
      root_path
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end
end
