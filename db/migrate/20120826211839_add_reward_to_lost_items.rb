class AddRewardToLostItems < ActiveRecord::Migration
  def change
    add_column :items, :reward, :decimal
  end
end
