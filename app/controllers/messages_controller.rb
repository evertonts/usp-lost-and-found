class MessagesController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]
    
  def create
    @message = Message.new(params[:message])
    @message.sender = current_user
    @message.recipient = params[:recipient_id]
    @message.save!
    redirect_to :back, :method => :get
  end
end
