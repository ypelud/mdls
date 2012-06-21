class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailer.signup_notification(user).deliver
  end

  def after_save(user)  
   UserMailer.activation(user).deliver if user.recently_activated?
   UserMailer.reset_notification(user).deliver if user.recently_reset?
  end
end
