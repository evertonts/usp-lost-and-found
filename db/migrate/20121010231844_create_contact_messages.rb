class CreateContactMessages < ActiveRecord::Migration
  def change
    create_table :contact_messages do |t|
      t.string :name
      t.string :body
      t.string :email
      t.timestamps
    end
  end
end
