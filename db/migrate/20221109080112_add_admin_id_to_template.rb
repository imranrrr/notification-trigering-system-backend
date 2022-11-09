class AddAdminIdToTemplate < ActiveRecord::Migration[7.0]
  def change
    add_column :templates, :admin_id, :integer, optional: true
    add_index :templates, :admin_id
  end
end
