class CreateIntegrations < ActiveRecord::Migration[7.0]
  def change
    create_table :integrations do |t|
      t.string :name
      t.string :client_id
      t.string :client_secret
      t.string :base_url
      t.string :expires_in
      t.string :refresh_token
      t.string :access_token
      t.string :code
      t.integer :admin_id

      t.timestamps
    end
    add_index :integrations, :client_id
    add_index :integrations, :admin_id
  end
end
