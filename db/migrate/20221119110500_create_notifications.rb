class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :template_id
      t.integer :endpoint_id
      t.integer :admin_id
      t.integer :user_id

      t.timestamps
    end
  end
end
