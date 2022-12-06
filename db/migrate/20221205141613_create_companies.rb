class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :sub_domain
      t.boolean :okta_sso_login, default: false

      t.timestamps
    end
  end
end
