# encoding: utf-8

class RepliesController < ApplicationController
  def create
    
    @reply = Reply.new(params[:reply])
    @reply.user = current_user
    
    if @reply.save
      redirect_to :back
    else
      redirect_to :back, :alert => "A resposta não pode ficar em branco" 
    end
  end
end
