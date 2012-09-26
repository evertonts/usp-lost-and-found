# encoding: utf-8

class RepliesController < ApplicationController
  def create
    
    @reply = Reply.new(params[:reply])
    @reply.user = current_user
    puts "\n\n\n\n\nLALALLAALALL\n\n\n\n\n"
    
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
end
