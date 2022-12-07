class RemoveColumnFromTemplate < ActiveRecord::Migration[7.0]
  def change
    remove_column :templates, :user_id, :integer
    rename_column :templates, :admin_id, :creator_id
    change_column :templates, :creator_id, :integer 
  end
end
