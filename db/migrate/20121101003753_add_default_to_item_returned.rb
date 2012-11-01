class AddDefaultToItemReturned < ActiveRecord::Migration
  def self.up
    change_column :items, :returned, :boolean, :default => false
  end
  
  def self.down
    change_column :items, :returned, :boolean, :default => nil
  end
end
