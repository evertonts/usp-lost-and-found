class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :text
      t.integer :sender_id
      t.integer :recipient_id
      t.string :title
      t.timestamps
    end
  end
end
