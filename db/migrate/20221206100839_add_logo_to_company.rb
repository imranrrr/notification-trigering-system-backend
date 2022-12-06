class AddLogoToCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :logo, :string
  end
end
