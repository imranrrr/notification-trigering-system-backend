class CreateEndpoints < ActiveRecord::Migration[7.0]
  def change
    create_table :endpoints do |t|
      t.string :name
      t.string :description
      t.integer :location_id
      t.integer :endpoint_group_id
      t.integer :destination_id
      t.integer :admin_id

      t.timestamps
    end
    add_index :endpoints, :location_id
    add_index :endpoints, :endpoint_group_id
    add_index :endpoints, :destination_id
    add_index :endpoints, :admin_id
  end
end
