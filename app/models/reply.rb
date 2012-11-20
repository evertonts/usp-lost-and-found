class Reply < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
  
  validates :text, presence: true
  validates :user_id, presence: true
  validates :message_id, presence: true
  
  def unread?
    !read?
  end  
  
  def read!
    update_attributes(:read => true)
  end
end
