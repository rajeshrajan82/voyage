class HomeController < ApplicationController
  before_filter :set_tab

  layout "map"
  
  def index
    @trip = Trip.find_by_tracking_code_and_track_status(params[:tracking_code], true)
    @trip_details = @trip.trip_details unless @trip.nil?
    @user = current_user
  end
  
  def trip_details
    @trip = Trip.find_by_tracking_code_and_track_status(params[:tracking_code], true)
    @trip_details = @trip.trip_details unless @trip.nil?
    @user = current_user
    respond_to do |format|
      format.html{render :action => "index"}
    end
  end
  
  private
  
  def set_tab
    @tab = "home"
  end
end
