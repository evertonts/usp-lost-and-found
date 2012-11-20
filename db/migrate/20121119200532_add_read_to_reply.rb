class AddReadToReply < ActiveRecord::Migration
  def change
    add_column :replies, :read, :boolean, :default => false
  end
end
