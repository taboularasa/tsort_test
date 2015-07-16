class CreateInventoryLocations < ActiveRecord::Migration
  def change
    create_table :inventory_locations do |t|
      t.timestamps null: false
    end
  end
end
