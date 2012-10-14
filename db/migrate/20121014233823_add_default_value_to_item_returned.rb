class AddDefaultValueToItemReturned < ActiveRecord::Migration
  def change
    change_column :items, :returned, :boolean, :default => false
  end
end
