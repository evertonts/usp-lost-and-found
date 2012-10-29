class Asset < ActiveRecord::Base
  belongs_to :items
  
  has_attached_file :asset, :styles => {
    :thumb => '150x150',
    :medium => '225x225',
    :large => '600x600'
  }
end
