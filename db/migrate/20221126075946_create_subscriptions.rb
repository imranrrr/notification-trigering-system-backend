class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.integer :status
      t.references :user
      t.references :package
      t.timestamps
    end
    add_index :subscriptions, :status
  end
end
