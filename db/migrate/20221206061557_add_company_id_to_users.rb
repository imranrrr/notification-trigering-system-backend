class AddCompanyIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :status, :integer, default: 0
    add_reference :users, :company, index: true
  end
end
