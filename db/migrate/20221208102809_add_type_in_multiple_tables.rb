class AddTypeInMultipleTables < ActiveRecord::Migration[7.0]
  def change
    add_column :templates, :creator_type, :integer, default: 1
    add_column :locations, :creator_type, :integer, default: 1
    add_column :web_signages, :creator_type, :integer, default: 1
    add_column :endpoint_groups, :creator_type, :integer, default: 1
    add_column :endpoints, :creator_type, :integer, default: 1
    add_column :destinations, :creator_type, :integer, default: 1
  end
end
