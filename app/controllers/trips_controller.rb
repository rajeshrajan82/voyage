class TripsController < ApplicationController
  before_filter :set_route
  layout "map"
  
  def trip_list
    if @current_trip.nil?
      @current_trip = Trip.new
    end
    puts @current_trip.inspect
    @previous_trips = @route.get_previous_trips.paginate(:page => 1, :per_page => 10)
    respond_to do |format|
      format.html {render :action => "trip_list"}
      format.json { render json: @trips }
    end
  end

  def create_trip
    @trip = current_user.trips.new(trip_params)
    @trip.route_id = @route.id
    respond_to do |format|
      if @trip.save
        format.html { redirect_to trip_list_path(:rid => @route.uuid), notice: 'Trip was successfully created.' }
      else
        @previous_trips = @route.get_previous_trips.paginate(:page => 1, :per_page => 10)
        format.html { render action: "trip_list" }
      end
    end
  end

  def update_trip
    @trip = Trip.find_by_uuid(params[:id])

    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to trip_list_path(:rid => @route.uuid), notice: 'Trip was successfully updated.' }
      else
        @previous_trips = @route.get_previous_trips.paginate(:page => 1, :per_page => 10)
        format.html { render action: "trip_list" }
      end
    end
  end

  def stop_tracking_trip
    @trip = Trip.find_by_uuid(params[:id])
    @trip.stop_tracking

    respond_to do |format|
      format.html { redirect_to trip_list_path(:rid => @route.uuid), notice: 'Stopped tracking successfully.' }
    end
  end
  
  private 
  
  def set_route
    @route = Route.find_by_uuid(params[:rid])
    @current_trip = @route.get_current_trip    
  end
  
  def trip_params
    params.require(:trip).permit(:created_by, :delete_status, :route_id, :track_status, :tracking_code)
  end
end
