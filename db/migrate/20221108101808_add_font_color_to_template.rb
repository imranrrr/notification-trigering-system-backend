class AddFontColorToTemplate < ActiveRecord::Migration[7.0]
  def change
    add_column :templates, :font_color, :string
    rename_column :templates, :color, :background_color
  end
end
