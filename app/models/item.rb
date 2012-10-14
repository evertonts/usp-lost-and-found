class Item < ActiveRecord::Base
  attr_accessible :assets_attributes, :description, :lost_date, :lost, :returned, :reward, :title, :tag_list
  has_many :assets
  belongs_to :user
  validates :user_id, :presence => true
  validates :title, presence: true
  validates :description, :presence => true
  validates_date :lost_date
  
  accepts_nested_attributes_for :assets, :allow_destroy => :true
  
  acts_as_taggable
    
  def main_image_thumb
    if assets.empty?
     "image_not_found_thumb.jpg"
    else
      assets.first.asset.url(:thumb)
    end
  end

  def main_image
    if assets.empty?
     "javascript:void(0)"
    else
      assets.first.asset.url(:original)
    end
  end
  
  def show_date
    lost_date.strftime("%d/%m/%Y") unless lost_date.nil?
  end
  
  def self.tagged_with_like(query)
    items = []
    ActsAsTaggableOn::Tag.where("name LIKE ?", "%#{query}%").each do |tag|
      items.concat Item.tagged_with(tag)
    end
    items
  end
end


