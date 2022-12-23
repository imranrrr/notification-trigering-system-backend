class CreateIcMobiles < ActiveRecord::Migration[7.0]
  def change
    create_table :ic_mobiles do |t|
      t.string :name
      
      t.timestamps
    end
  end
end
