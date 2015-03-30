class Route < ActiveRecord::Base
  uuid_it
  belongs_to :user
  belongs_to :vehicle
  has_many :trips
  
  validates :origin, :presence=> true
  validates :destination, :presence=> true
  
  def get_previous_trips
    trips.where(:track_status => false).order("id desc")
  end

  def get_current_trip
    trips.find_by_track_status(true)
  end
  
  def fetch_current_trip
    trips.where(:track_status => true, :delete_status => false).first
  end
end
