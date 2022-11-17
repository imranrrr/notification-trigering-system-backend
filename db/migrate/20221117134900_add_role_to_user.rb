class AddRoleToUser < ActiveRecord::Migration[7.0]
  def change
    remove_column(:users, :name, :string)
    add_column(:users, :first_name, :string)
    add_column(:users, :last_name, :string)
    add_column :users, :role, :integer, default: 0
    add_column :users, :bypass_user, :boolean, default: false
  end
end
