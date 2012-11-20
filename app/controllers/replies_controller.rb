# encoding: utf-8

class RepliesController < ApplicationController
  def create
    
    @reply = Reply.new(params[:reply])
    @reply.user = current_user
    
    respond_to do |format|
      if @reply.save
        format.js
      else
        format.js { render :partial => 'error' }
      end
    end
  end
  
  def new
    @reply = Reply.new
    @message = Message.find(params[:message_id])
    render :partial => "send_reply", :locals => {:reply => @reply}
  end
  
  def mark_as_read
    message = Message.find(params[:message_id])
    
    message.unread_replies.select{|r| r.user != current_user}.each do |reply|
      reply.read!
    end
  end
end
