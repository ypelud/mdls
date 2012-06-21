class EmailerController < ApplicationController

  def sendmail
    Emailer.contact(current_user, params[:email][:cc_mail] == "1" ? current_user.email : "", params[:email][:subject], params[:email][:message]).deliver
    return if request.xhr?
      
    redirect_to :action => 'thanks'
   end
end