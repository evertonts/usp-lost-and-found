class CreateItems < ActiveRecord::Migration
  def change
      create_table :items do |t|
      
      t.string :description
      t.date :lost_date
      t.boolean :lost #True if the item was lost and false if it was found
      t.boolean :returned #True if the item was returned to its owner
      
      t.timestamps
    end
  end
end
