class CreatePackages < ActiveRecord::Migration[7.0]
  def change
    create_table :packages do |t|
      t.string :name
      t.integer :price
      t.integer :duration, default: 0
    end
  end
end
