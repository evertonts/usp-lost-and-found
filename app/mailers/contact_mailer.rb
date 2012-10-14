class ContactMailer < ActionMailer::Base
  
  default :to => "everton2x4@gmail.com"
  default :from => "contato.achusp@gmail.com"
  def new_message(message)
    @message = message
    mail(:subject => "[ACHUSP] Email de contato")
  end
    
end
