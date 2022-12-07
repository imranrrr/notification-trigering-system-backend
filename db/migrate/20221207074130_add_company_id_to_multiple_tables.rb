class AddCompanyIdToMultipleTables < ActiveRecord::Migration[7.0]
  def change
    add_column(:locations, :company_id, :integer)
    add_column(:endpoint_groups, :company_id, :integer)
    add_column(:endpoints, :company_id, :integer)
    add_column(:web_signages, :company_id, :integer)
    add_column(:destinations, :company_id, :integer)
  end
end
