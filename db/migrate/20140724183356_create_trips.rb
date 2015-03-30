class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :route_id
      t.string :tracking_code
      t.boolean :track_status, :default => true
      t.boolean :delete_status, :default => false
      t.integer :user_id

      t.timestamps
    end
  end
end
