class EmailerController < ApplicationController

  before_filter :init
  
  def init
    @selectedMenu = 'contact'
  end

  def sendmail
    email = params[:email]
    cc = current_user.email if  params[:cc_mail] == "1"
    subject = email[:subject]
    message = email[:message]
    login = current_user.login
    Emailer.deliver_contact(login, cc, subject, message)
    return if request.xhr?
    redirect_to :action => 'thanks'
  end
  
end