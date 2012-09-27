class Item < ActiveRecord::Base
  attr_accessible :assets_attributes, :description, :lost_date, :lost, :returned, :reward, :title
  has_many :assets
  belongs_to :user
  validates :user_id, :presence => true
  validates :title, presence: true
  validates :description, :presence => true
  validates :reward, :numericality => {:greater_than => 0}, :allow_nil => true
  validates_date :lost_date
  
  accepts_nested_attributes_for :assets, :allow_destroy => :true
    
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
  
end


