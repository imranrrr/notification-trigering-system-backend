class ChangeColumnTypeInLocation < ActiveRecord::Migration[7.0]
  def change
    remove_column(:locations, :web_signage, :string)
    add_column(:locations, :web_signage_id, :integer)
    add_column(:locations, :description, :string)

  end
end
