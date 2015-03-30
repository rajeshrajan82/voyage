class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.integer :user_id
      t.string :v_no
      t.string :v_name
      t.string :v_type
      t.string :v_seat_type
      t.integer :created_by
      t.boolean :status, :default => true
      t.boolean :delete_status, :default => false

      t.timestamps
    end
  end
end
