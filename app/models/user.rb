class User < ActiveRecord::Base
	rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  has_many :items
  has_many :sent_messages, :class_name => Message, :foreign_key => 'sender_id'
  has_many :received_messages, :class_name => Message, :foreign_key => 'recipient_id'
  
  validates :name, :presence => true
  
  def all_messages
    aux = sent_messages
    aux = aux + received_messages
    aux
  end
  
  def conversation_with(user)
    Message.where("(sender_id=? AND recipient_id=?) 
      OR (sender_id=? AND recipient_id=?)", self.id, user.id, self.id, user.id).order("created_at DESC")
  end
end
