class CreateTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :templates do |t|
      t.string :name
      t.string :subject
      t.string :body
      t.string :audio
      t.string :color
      t.integer :user_id

      t.timestamps
    end
    add_index :templates, :user_id
  end
end
