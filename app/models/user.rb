class User < ActiveRecord::Base
  has_one :profil
  has_many :authentications 
  
  acts_as_authentic do |c|
    c.transition_from_restful_authentication = true
  end
  
  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
  
end
