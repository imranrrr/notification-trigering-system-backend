class AddColumnToMultipleTables < ActiveRecord::Migration[7.0]
  def change
    add_reference :locations, :admin, :foreign_key => true
    add_reference :endpoints, :admin, :foreign_key => true
    add_reference :endpoint_groups, :admin, :foreign_key => true
    add_reference :destinations, :admin, :foreign_key => true
    add_reference :companies, :admin, :foreign_key => true
    add_reference :templates, :admin, :foreign_key => true
    add_reference :web_signages, :admin, :foreign_key => true

  end
end
