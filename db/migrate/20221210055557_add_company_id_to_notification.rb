class AddCompanyIdToNotification < ActiveRecord::Migration[7.0]
  def change
    remove_column :notifications, :user_id, :integer
    add_reference :notifications, :company, foreign_key: true
    add_column :notifications, :creator_id, :integer
  end
end
