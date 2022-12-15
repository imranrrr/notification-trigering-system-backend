class AddColumnToPackages < ActiveRecord::Migration[7.0]
  def change
    add_column :packages, :locations_creating_limit, :integer
    add_column :packages, :endpoints_creating_limit, :integer
    add_column :packages, :endpoint_groups_creating_limit, :integer
    add_column :packages, :users_creating_limit, :integer
    add_column :packages, :created_at, :datetime, null: false
    add_column :packages, :updated_at, :datetime, null: false
  end
end
