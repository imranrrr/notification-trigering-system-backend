class CreateDestinations < ActiveRecord::Migration[7.0]
  def change
    create_table :destinations do |t|
      t.integer :destination_type, default: 0
      t.string :resource_url
      t.integer :network_distribution_id
      t.integer :admin_id

      t.timestamps
    end
    add_index :destinations, :admin_id
  end
end
