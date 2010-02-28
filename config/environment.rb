# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
#ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.3' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')


Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.action_controller.session = {
    :session_key => '_menuCatalog_session',
    :secret      => 'ac84c451c5f202e73df99a1612e1ca93c23fd6877e8bdda11222f9d8b3a0c09a98da9d710633c8aedf7d21243ee876a701324cec19e73070c1599581b2fbd577'
  }
  config.active_record.observers = :user_observer
end


#localization france
#require 'french_errors_localization'

#config prawn

