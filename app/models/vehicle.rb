class Vehicle < ActiveRecord::Base
  uuid_it
  
  belongs_to :user
  has_many :routes
  
  validates :v_no, :presence=> true
  
  def get_active_routes
    routes.where(:delete_status => false)
  end
end
