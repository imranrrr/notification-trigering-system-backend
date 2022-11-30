class AddStripeAccountIntentToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :stripe_account_intent, :string
    add_index :users, :stripe_account_intent
  end
end
