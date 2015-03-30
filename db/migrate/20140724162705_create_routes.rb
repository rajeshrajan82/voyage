class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :vehicle_id
      t.integer :user_id
      t.string :origin
      t.string :destination
      t.boolean :status, :default => true
      t.boolean :delete_status, :default => false
      t.integer :created_by

      t.timestamps
    end
  end
end
