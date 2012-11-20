class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => User, :foreign_key => 'sender_id'
  belongs_to :recipient, :class_name => User, :foreign_key => 'recipient_id'
  belongs_to :item
  has_many :replies, :class_name => Reply
  
  validates :item_id, :presence => true
  validates :text, :presence => true
  
  def unread?
    !read?
  end
  
  def read!
    update_attributes(:read => true)
  end
  
  def unread_replies
    replies.select{|r| r.unread?}
  end
  
end
