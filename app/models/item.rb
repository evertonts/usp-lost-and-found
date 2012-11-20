# encoding: utf-8

class Item < ActiveRecord::Base
  attr_accessible :assets_attributes, :description, :lost_date, :lost, :returned, :reward, :title, :tag_list
  has_many :assets
  has_many :messages
  belongs_to :user
  validates :user_id, :presence => true
  validates :title, presence: true
  validates :description, :presence => true
  validates_date :lost_date
  validates_date :lost_date, :before => lambda { Date.today + 1.day }, 
    :before_message => "Data inválida"
  
  accepts_nested_attributes_for :assets, :allow_destroy => :true
  
  acts_as_taggable
  
  searchable do
    text :title, :boost => 2.0
    text :description
    boolean :lost
    boolean :returned
    
    text :tag_list do
      tag_list.map {|tag| tag}
    end
  end
    
  def main_image_thumb
    if assets.empty?
     "image_not_found_thumb.jpg"
    else
      assets.first.asset.url(:thumb)
    end
  end
  
  def main_image_medium
    if assets.empty?
     "image_not_found_medium.jpg"
    else
      assets.first.asset.url(:medium)
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
    if lost_date.nil?
      Time.now.strftime("%d/%m/%Y")
    else
      lost_date.strftime("%d/%m/%Y")
    end
  end
  
  def user_messages(user)
    _messages = messages.select{|m| m.sender == user}
    _messages.sort {|a, b| b.created_at <=> a.created_at}
  end
  
  def unread_messages(user)
    messages.select{|m| m.recipient == user && m.unread?}
  end
  
  def unread_replies(user)
    unread = []
    messages.select{|m| (m.sender == user) || (m.recipient == user) }.each do |message|
      unread.concat message.replies.select{|r| (r.user != user) && r.unread? }
    end
    
    unread
  end
  
  def all_unread_count(user)
    unread_messages(user).count + unread_replies(user).count
  end
  
  def all_unread_presentation(user)
    count = all_unread_count(user)
    if count == 0
      "Não há novas mensagens"
    else
      count
    end
  end
  
end


