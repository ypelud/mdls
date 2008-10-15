class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Activez votre compte.'
  
    @body[:url]  = "#{APP_CONFIG['host']}/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Votre compte été activé'
    @body[:url]  = "#{APP_CONFIG['host']}"
  end
     
     
   def reset_notification(user)
     setup_email(user)
     @subject    += 'Lien pour changer votre mot de passe'
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