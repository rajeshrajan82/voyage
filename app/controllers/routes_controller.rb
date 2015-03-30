class RoutesController < ApplicationController
  before_filter :set_vehicle
  
  def route_list
    @routes = @vehicle.get_active_routes
    @route = Route.new
    respond_to do |format|
      format.html {render :action => "route_list"}
      format.json { render json: @routes }
    end
  end


  # GET /routes/1/edit
  def edit_route
    @route = Route.find_by_uuid(params[:rid])
    @routes = @vehicle.get_active_routes
    respond_to do |format|
      format.html {render :action => "route_list"}
    end
  end

  def create_route
    @route = @vehicle.routes.new(route_params)
    @route.user_id = @customer.id
    @route.created_by = current_user.id
    respond_to do |format|
      if @route.save
        format.html { redirect_to route_list_path(:vid => @vehicle.uuid), notice: 'successfully created.' }
      else
        @routes = @vehicle.get_active_routes
        format.html { render action: "route_list" }
      end
    end
  end

  # PUT /routes/1
  # PUT /routes/1.json
  def update_route
    @route = Route.find_by_uuid(params[:rid])

    respond_to do |format|
      if @route.update(route_params)
        format.html { redirect_to route_list_path(:vid => @vehicle.uuid), notice: 'successfully updated.' }
      else
        @routes = @vehicle.get_active_routes
        format.html { render action: "route_list" }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy_route
    @route = Route.find_by_uuid(params[:rid])
    @route.update_attributes(:delete_status => true)

    respond_to do |format|
      format.html { redirect_to route_list_path(:vid => @vehicle.uuid), notice: 'successfully deleted.' }
    end
  end
  
  
  private
  
  def set_vehicle
    @vehicle = Vehicle.find_by_uuid(params[:vid])    
    @user = @vehicle.user
    if !@user.parent_id.nil?
      @customer = @user.parent
    else
      @customer = @user
    end
  end
  
  def route_params
    params.require(:route).permit(:destination, :origin, :status, :user_id, :vehicle_id, :delete_status)
  end
end
