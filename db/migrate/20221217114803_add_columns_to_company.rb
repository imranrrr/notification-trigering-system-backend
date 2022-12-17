class AddColumnsToCompany < ActiveRecord::Migration[7.0]
  def change
    add_column(:companies, :paid, :integer, :default => 0)
    add_column(:companies, :stripe_account_intent, :string)
    remove_column(:users, :paid, :boolean, :default => false )
    remove_column(:users, :stripe_account_intent, :string)
    change_column(:subscriptions,  :status, :integer, :default => 0)
  end
end
