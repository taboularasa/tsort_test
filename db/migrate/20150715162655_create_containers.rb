class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.belongs_to :inventory_location, index: true, foreign_key: true
      t.belongs_to :container, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
