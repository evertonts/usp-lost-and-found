class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => User, :foreign_key => 'sender_id'
  belongs_to :recipient, :class_name => User, :foreign_key => 'recipient_id'
  belongs_to :item
  has_many :replies, :class_name => Reply
  
  validates :item_id, :presence => true
  validates :text, :presence => true
  
  acts_as_readable :on => :created_at
end
