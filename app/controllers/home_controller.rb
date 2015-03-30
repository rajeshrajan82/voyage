class HomeController < ApplicationController
  before_filter :set_tab

  layout "map", :only => [:index]
  
  def index
    @trip = Trip.find_by_tracking_code_and_track_status(params[:tracking_code], true)
    @trip_details = @trip.trip_details unless @trip.nil?
    @user = current_user
  end
  
  private
  
  def set_tab
    @tab = "home"
  end
end
