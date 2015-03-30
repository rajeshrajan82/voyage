class TripDetail < ActiveRecord::Base
  belongs_to :trip

  validates :latitude, :presence=> true
  validates :longitude, :presence=> true
  validates :trip_id, :presence=> true
  validates :sno, :presence=> true
  
end
