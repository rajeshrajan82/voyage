class Trip < ActiveRecord::Base
  uuid_it
  belongs_to :route
  has_many :trip_details
  belongs_to :user
  
  validates :tracking_code, :presence=> true
  
  def stop_tracking
    self.update_attributes(:track_status => false)
  end



  # Class methods
  class << self
    def fetch_current_trip
      Trip.find_by_track_status_and_delete_status(true, false)
    end
  end
end
