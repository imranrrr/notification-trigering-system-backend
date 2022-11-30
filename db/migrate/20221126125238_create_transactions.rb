class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :user
      t.references :package
      t.references :subscription

      t.timestamps
    end
  end
end
