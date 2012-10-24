class ContactController < ApplicationController
  before_filter :store_location
  
  before_filter :authenticate_user!
    
  def new
    @message = ContactMessage.new    
  end
  
  def create
    @message = ContactMessage.new(params[:contact_message])
    
    puts "n\n\n\n\n\n" + @message.body
    @message.name = current_user.name
    @message.email = current_user.email
    
    if @message.valid?
      ContactMailer.new_message(@message).deliver
      redirect_to(root_path, :notice => "Sua mensagem foi enviada")
    else
      flash.now.alert = "Por favor, preencha a mensagem"
      render :new
    end
  end
  
end