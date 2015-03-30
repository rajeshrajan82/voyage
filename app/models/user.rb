class User < ActiveRecord::Base
  AGENT = "AGENT"
  ADMIN = "ADMIN"
  CUSTOMER = "CUSTOMER"

  uuid_it
  
  has_many :vehicles
  has_many :routes
  has_many :trips
  
  belongs_to :parent, :class_name => 'User', :foreign_key => :parent_id
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  
  validates :email, :presence=> true
  validates :travels_name, :presence=> true

  before_save :save_defaults

  def save_defaults
    self.authentication_code ||= rand(36**8).to_s(36)
    # If the user is a customer created by us it is ADMIN
    # If a customer creates a user they are agents
    self.user_sub_type ||= self.parent.blank? ? ADMIN : AGENT
    # User will be customer in all scenarios
    self.user_type ||= CUSTOMER
  end
  
  def is_admin?
    self.user_type == ADMIN
  end
  
  def is_customer?
    self.user_type == CUSTOMER
  end

  def is_sub_type_admin?
   self. user_sub_type == ADMIN
  end
  
  def is_sub_type_agent?
    self. user_sub_type == AGENT
  end
  
  def get_auth_code
    if self.parent_id.nil?
      self.authentication_code.upcase
    else
      self.parent.authentication_code.upcase
    end
  end

  def get_active_vehicles
    vehicles.where(:status => false)
  end

  def get_active_routes
    routes.where(:status => true, :delete_status => false)
  end
  
  def get_inactive_routes
    routes.where(:status => false, :delete_status => false)
  end

  def inactivate!
    update_attributes(:delete_status => true)
  end

  def update_status
    update_attributes(:status => self.status ^= true)
  end

  class << self
    def get_customers
      User.find_all_by_user_type_and_user_sub_type(CUSTOMER, ADMIN)
    end

    def get_active_agents(customer)
      User.where(:user_sub_type => AGENT, :parent_id => customer.id, :delete_status => false)
    end
  end
end
