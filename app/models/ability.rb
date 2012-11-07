class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    else
      can :show, Item
      can [:create, :new_lost, :new_found, :autocomplete_tag_name, :tag], Item
      can [:search], Item
      
      can [:update, :destroy, :recover], Item do |item|
        item.user == user
      end 
      
      can :show, User do |user1|
        user1 == user
      end
      
      can :create, Message
      
      can :show, Message do |message|
        message.sender == user || message.recipient == user
      end
    end
  end
end
