# encoding: utf-8

class MessagesController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]
  load_and_authorize_resource
  
  after_filter :read, :only => [:create]
  
  def read
    User.all.each do |user|
      @message.mark_as_read! :for => user unless @message.recipient == user
    end
  end
  
  def create
    @message = Message.new(params[:message])
    @message.item = Item.find(params[:item_id])
    @message.title = @message.item.title
    @message.sender = current_user
    
    if @message.save
      redirect_to :back, :method => :get, :notice => "Sua mensagem foi enviada"
    else
      redirect_to :back, :method => :get, :alert => "A mensagem não pode ficar em branco"
    end
  end
  
  def show
    @message = Message.find(params[:id])
    #@reply = Reply.new
  end
  
  def mark_as_read
    item = Item.find(params[:item_id])
    
    for message in item.messages
      message.mark_as_read!(:for => current_user) if Message.unread_by(current_user).include? message
    end
    respond_to do |format|
      format.js
    end
  end
  
end
