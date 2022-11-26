class AddProviderToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :paid, :boolean, default: false
    add_index :users, :provider
    add_index :users, :uid
  end
end
