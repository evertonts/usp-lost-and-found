class CreateItems < ActiveRecord::Migration
  def change
      create_table :items do |t|
      
      t.string :title
      t.string :description
      t.date :lost_date
      t.boolean :lost #True if the item was lost and false if it was found
      t.boolean :returned #True if the item was returned to its owner
      t.integer :user_id
      t.decimal :reward
      
      t.timestamps
    end
  end
end
