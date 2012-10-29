# encoding: utf-8

class MessagesController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]
  load_and_authorize_resource
  
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
end
