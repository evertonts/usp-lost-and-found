class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      
      t.integer :message_id
      t.text :text
      t.integer :user_id
      t.timestamps
    end
  end
end
