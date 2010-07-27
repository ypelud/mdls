class Emailer < ActionMailer::Base

       
  def contact(login, cc, subject, message, sent_at = Time.now)
      @subject = subject
      @recipients = APP_CONFIG['mail_to']
      @from = APP_CONFIG['mail_from']
      @cc = cc
      @sent_on = sent_at	   
  	  @body["message"] = message
      @body["login"] = login
      @headers = {}
   end


end
