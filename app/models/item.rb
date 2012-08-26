class Item < ActiveRecord::Base
  attr_accessible :assets_attributes, :description, :lost_date, :lost, :returned, :reward
  has_many :assets
  accepts_nested_attributes_for :assets, :allow_destroy => :true
end
