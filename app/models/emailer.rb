class Emailer < ActionMailer::Base

       
  def contact(login, cc, subject, message, sent_at = Time.now)
      @subject = subject
      @recipients = MDSL_MAIL_TO
      @from = MDSL_MAIL_FROM
      @cc = cc
      @sent_on = sent_at	   
  	  @body["message"] = message
      @body["login"] = login
      @headers = {}
   end


end
