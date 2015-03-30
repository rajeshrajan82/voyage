class VehiclesController < ApplicationController
  before_filter :set_user_and_customer
  before_filter :set_tab
  
  def vehicle_list
    @vehicles = @customer.get_active_vehicles
    @vehicle = Vehicle.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vehicles }
    end
  end

  def edit_vehicle
    @vehicle = Vehicle.find_by_uuid(params[:vid])
    @vehicles = @customer.get_active_vehicles
    respond_to do |format|
      format.html {render :action => "vehicle_list"}
    end
  end

  # POST /vehicles
  # POST /vehicles.json
  def create_vehicle
    @vehicle = @customer.vehicles.new(vehicle_params)
    @vehicle.status = true
    @vehicle.created_by = current_user.id
    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to vehicle_list_path(:id => @user.uuid), notice: 'successfully created.' }
      else
        @vehicles = @customer.get_active_vehicles
        format.html { render action: "vehicle_list" }
      end
    end
  end

  def update_vehicle
    @vehicle = Vehicle.find_by_uuid(params[:vid])

    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to vehicle_list_path(:id => @user.uuid), notice: 'successfully updated.' }
      else
        @vehicles = @customer.get_active_vehicles
        format.html { render action: "vehicle_list" }
      end
    end
  end

  # DELETE /vehicles/1
  # DELETE /vehicles/1.json
  def destroy_vehicle
    @vehicle = Vehicle.find_by_uuid(params[:vid])
    @vehicle.update_attributes(:delete_status => true)

    respond_to do |format|
      format.html { redirect_to vehicle_list_path(:id => @user.uuid), notice: 'successfully deleted.' }
    end
  end
  
  private
  
  def set_user_and_customer
    @user = User.find_by_uuid(params[:id])
    if !@user.parent_id.nil?
      @customer = @user.parent
    else
      @customer = @user
    end
  end
  
  def set_tab
    @tab = "vehicle"
  end
  
  def vehicle_params
    params.require(:vehicle).permit(:user_id, :v_name, :v_no, :v_seat_type, 
      :v_type, :status, :delete_status)
  end
end
