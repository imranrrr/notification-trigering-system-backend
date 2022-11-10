class CreateWebSignages < ActiveRecord::Migration[7.0]
  def change
    create_table :web_signages do |t|
      t.string :name
      t.integer :scroller_speed
      t.string :landscape_title_width
      t.string :landscape_title_height
      t.string :landscape_title_top
      t.string :landscape_title_left
      t.string :landscape_description_width
      t.string :landscape_description_height
      t.string :landscape_description_top
      t.string :landscape_description_left
      t.string :potrait_title_width
      t.string :potrait_title_height
      t.string :potrait_title_top
      t.string :potrait_title_left
      t.string :potrait_description_width
      t.string :potrait_description_height
      t.string :potrait_description_top
      t.string :potrait_description_left

      t.timestamps
    end
  end
end
