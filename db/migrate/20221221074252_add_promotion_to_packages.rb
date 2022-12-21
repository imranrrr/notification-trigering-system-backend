class AddPromotionToPackages < ActiveRecord::Migration[7.0]
  def change
    add_column :packages, :promotion, :string
  end
end
