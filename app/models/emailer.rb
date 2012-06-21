class Emailer < ActionMailer::Base
  default :from => APP_CONFIG['mail_from']
  
       
  def contact(user, cc, subject, message, sent_at = Time.now)      
      @message = message
      @user = user
      mail(:to => APP_CONFIG['mail_to'], 
           :subject => subject, 
           :cc => cc, 
           :reply_to => user.email)
   end


end
