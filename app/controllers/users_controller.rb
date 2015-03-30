class UsersController < Devise::RegistrationsController
  before_filter :set_tab, :except => [:dashboard, :edit_profile]
  before_filter :set_customer, :only => [:dashboard, :edit_profile, :update_profile]
  prepend_before_filter :authenticate_scope!
  
  def customer_list
    @customers = User.get_customers
    @user = User.new
  end
  
  def create_user
    @user = User.new(user_params)
    if !params[:id].nil?
      @customer = User.find_by_uuid(params[:id])
      @user.parent = @customer
    end
    if @user.valid?
      @user.save
      if params[:id].nil?
        redirect_to customers_path, :notice => "Successfully Created"
      else
        redirect_to agents_path(:id => @customer.uuid), :notice => "Successfully Created"
      end
    else
      if params[:id].nil?
        @customers = User.get_customers
        render :action => "customer_list"
      else
        @agents = User.get_active_agents(@customer)
        render :action => "agent_list"
      end
    end
  end
  
  def change_status
    @user = User.find_by_uuid(params[:id])
    @user.update_status
    if @user.is_sub_type_admin?
      redirect_to customers_path
    else
      customer = @user.parent
      redirect_to agents_path(:id => customer.uuid)
    end
  end
  
  def edit_user
    @user = User.find_by_uuid(params[:id])
    if @user.is_sub_type_admin?
      @customers = User.find_all_by_user_type("customer")
      render :action => "customer_list"
    else
      @customer = @user.parent
      @agents = User.get_active_agents(@customer)
      render :action => "agent_list"
    end
  end
  
  def update_user
    @user = User.find_by_uuid(params[:id])
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    @user.update(user_params)
    if params[:customer_id].nil?
      redirect_to customers_path, :notice => "Updated Successfully"
    else
      redirect_to agents_path(:id => params[:customer_id]), :notice => "Updated Successfully"
    end
  end
  
  def delete_user
    @user = User.find_by_uuid(params[:id])
    @user.inactivate!
    redirect_to agents_path(:id => @user.parent.uuid, :notice => "Deleted Successfully")
  end
  
  def agent_list
    @customer = User.find_by_uuid(params[:id])
    @agents = User.get_active_agents(@customer)
    @user = User.new
  end
  
  def dashboard
    @user = nil
  end
  
  def edit_profile
    @user = current_user
    render :action => "dashboard"
  end
  
  def update_profile
    if current_user.update_with_password(params[:user])
      redirect_to dashboard_path(:notice => "Successfully Updated")
    else
      @user = current_user
      render :action => "dashboard"
    end
  end
  
  private
  
  def set_customer
    puts current_user.inspect
    if current_user.is_customer? && current_user.is_sub_type_admin?
      @customer = current_user
    elsif current_user.is_sub_type_agent?
      @customer = current_user.parent
      puts current_user
      puts current_user.parent
    end
    @tab = "dashboard"
  end
  
  def set_tab
    @tab = "user"
  end

  def user_params
    params.require(:user).permit(:travels_name, :password, :password_confirmation, 
      :email, :address, :city, :state, :country, :phone, :mobile, 
      :contactus_email, :status, :delete_status)
  end
end
