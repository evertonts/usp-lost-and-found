class AddNameAndAvatarToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_attachment :users, :avatar
  end
  
  def self.down
    remove_attachment :users, :avatar
  end
end