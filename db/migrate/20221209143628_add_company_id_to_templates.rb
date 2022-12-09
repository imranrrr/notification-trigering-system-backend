class AddCompanyIdToTemplates < ActiveRecord::Migration[7.0]
  def change
    add_reference :templates, :company, foreign_key: true
  end
end
