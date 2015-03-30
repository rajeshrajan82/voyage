class TrackingController < ApplicationController
  before_filter :set_default_response_format
  
  def validate_authentication
    @user = User.find_by_authentication_code_and_status(params[:aid], true)
    if @user.nil?
      render :json => {:status => :error, :message => "Invalid Authentication Code"}.to_json
    else
      @routes = @user.get_active_routes
      render :json => {:status => :ok, :message => "Success", :name => @user.travels_name, :routes => @routes.to_json(:only => [:id, :origin, :destination])}
    end
  end
  
  def get_trip
    @route = Route.find(params[:rid])
    @trip = @route.fetch_current_trip
    if @trip.nil?
      render :json => {:status => :error, :message => "Trip not created"}.to_json
    else
      render :json => {:status => :ok, :message => "Success", :trip_id => @trip.id, :track_status => @trip.track_status}
    end
  end
  
  def save_position
    begin
      @trip = Trip.find(params[:trip_id])
      params[:trip_details].each do |trip_detail|
        t_detail = TripDetail.new(:trip_id => @trip.id, :latitude => trip_detail[:latitude],
          :longitude => trip_detail[:longitude], :sno => trip_detail[:sno])
        t_detail.save
      end  
      render :json => {:status => :ok, :track_status => @trip.track_status}
    rescue
      render :json => {:status => :error}.to_json
    end  
  end

private
  def set_default_response_format
    request.format = :json
  end
end
