class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :locations, :admin_id, :creator_id
    change_column :locations, :creator_id, :integer

    rename_column :endpoint_groups, :admin_id, :creator_id
    change_column :endpoint_groups, :creator_id, :integer

    rename_column :endpoints, :admin_id, :creator_id
    change_column :endpoints, :creator_id, :integer

    add_column :web_signages, :creator_id, :integer

    rename_column :destinations, :admin_id, :creator_id
    change_column :destinations, :creator_id, :integer
  end
end
