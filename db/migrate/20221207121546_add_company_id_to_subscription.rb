class AddCompanyIdToSubscription < ActiveRecord::Migration[7.0]
  def change
    add_reference :subscriptions, :company, foreign_key: true
    remove_column :subscriptions, :user_id, :integer
  end
end
