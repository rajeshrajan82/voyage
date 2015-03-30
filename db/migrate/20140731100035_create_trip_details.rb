class CreateTripDetails < ActiveRecord::Migration
  def change
    create_table :trip_details do |t|
      t.integer :trip_id
      t.string :latitude
      t.string :longitude
      t.integer :sno

      t.timestamps
    end
  end
end
