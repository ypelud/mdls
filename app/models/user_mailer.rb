class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += I18n.t(:activation_required_email_subject)
    @body[:url]  = "#{APP_CONFIG['host']}/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += I18n.t(:activation_complete_email_subject)
    @body[:url]  = "#{APP_CONFIG['host']}"
  end
     
     
   def reset_notification(user)
     setup_email(user)
     @subject    += I18n.t(:reset_notification_email_subject)
     @body[:url]  = "#{APP_CONFIG['host']}/reset/#{user.reset_code}"
   end

  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "#{APP_CONFIG['mail_from']}"
      @subject     = "#{APP_CONFIG['host']} "
      @sent_on     = Time.now
      @body[:user] = user
    end
end