class CreateEndpointGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :endpoint_groups do |t|
      t.string :name
      t.string :description
      t.integer :endpoint_type, default: 1
      t.integer :admin_id

      t.timestamps
    end
    add_index :endpoint_groups, :admin_id
    add_index :endpoint_groups, :name
  end
end
