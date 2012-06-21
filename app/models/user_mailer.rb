class UserMailer < ActionMailer::Base
  default :from => "#{APP_CONFIG['mail_from']}"
  
  def signup_notification(user)
    @user = user
    @url  = "#{APP_CONFIG['host']}/activate/#{user.activation_code}"
    mail(:to => user.email, :subject => I18n.t(:activation_required_email_subject))  
  end
  
  def activation(user)
    @user = user
    @url  = "#{APP_CONFIG['host']}"
    mail(:to => user.email, :subject => I18n.t(:activation_complete_email_subject))  
  end
     
     
   def reset_notification(user)
     @user = user
     @url  = "#{APP_CONFIG['host']}/reset/#{user.reset_code}"
     mail(:to => user.email, :subject => I18n.t(:reset_notification_email_subject))  
   end

end