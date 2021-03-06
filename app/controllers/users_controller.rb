class UsersController < ApplicationController
  before_filter :authenticate_user! 
  
  load_and_authorize_resource
  
  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @items = @user.items.order("created_at desc")
    @messages = current_user.all_messages
    
    @others_items = []
    
    @user.sent_messages.each do |message|
      @others_items << message.item unless @others_items.include? message.item
    end
    
    respond_to do |format|
      format.js
      format.html
    end
  end

end
