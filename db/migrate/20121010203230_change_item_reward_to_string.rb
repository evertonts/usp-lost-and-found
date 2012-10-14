class ChangeItemRewardToString < ActiveRecord::Migration
  def up
    change_column :items, :reward, :string
  end

  def down
    change_column :items, :reward, :decimal
  end
end
