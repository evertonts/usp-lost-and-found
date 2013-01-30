class ContactController < ApplicationController
  before_filter :store_location
    
  def new
    @message = ContactMessage.new    
    @login = !current_user.nil?
  end
  
  def create
    @message = ContactMessage.new()
    p = params[:contact_message]
    @message.body = p[:body]
    
    if p[:login] != "false"
      @message.name = current_user.name
      @message.email = current_user.email
    else
      @message.name = p[:name]
      @message.email = p[:email]
    end
    
    
    if @message.valid?
      ContactMailer.new_message(@message).deliver
      redirect_to(root_path, :notice => "Sua mensagem foi enviada")
    else
      flash.now.alert = "Por favor, preencha todos os campos"
      render :new
    end
  end
  
end
