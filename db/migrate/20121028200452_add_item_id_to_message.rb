class AddItemIdToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :item_id, :integer
  end
end
