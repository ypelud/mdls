class EmailerController < ApplicationController

   def sendmail
      email = params[:email]
      if  params[:cc_mail] == "1"
        cc = current_user.email
        end
	   subject = email[:subject]
	   message = email[:message]
      login = current_user.login
      Emailer.deliver_contact(login, cc, subject, message)
      return if request.xhr?
        redirect_to :action => 'thanks'
   end
end