# Load the rails application
require File.expand_path('../settings', __FILE__)
require File.expand_path('../application', __FILE__)

ENV['RECAPTCHA_PUBLIC_KEY']  = CAPTCHA_PUB_KEY
ENV['RECAPTCHA_PRIVATE_KEY'] = CAPTCHA_PRI_KEY

ENV['MDSL_HOST'] = MDSL_HOST 
ENV['MDSL_MAIL_TO'] =  MDSL_MAIL_TO
ENV['MDSL_MAIL_FROM'] = MDSL_MAIL_FROM
ENV['MDSL_SUPER_USER'] = MDSL_SUPER_USER

# Initialize the rails application
Mdls::Application.initialize!
