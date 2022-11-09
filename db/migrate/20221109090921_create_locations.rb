class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :web_signage
      t.integer :admin_id

      t.timestamps
    end
    add_index :locations, :admin_id
    add_index :locations, :web_signage
  end
end
