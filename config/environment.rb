# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
#ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')


Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  
  config.i18n.load_path << Dir[File.join(RAILS_ROOT, 'config', 'locales', 'rails', '*.{rb,yml}')]
  config.i18n.default_locale = :fr 
  
  config.action_controller.session_store = :active_record_store 
  config.active_record.observers = :user_observer

  config.gem 'will_paginate'
  config.gem 'jackdempsey-acts_as_commentable', :lib => 'acts_as_commentable'
  config.gem 'acts_as_taggable_on_steroids'
  config.gem 'authlogic', :version => '2.1.3'
  config.gem 'ambethia-recaptcha', :lib => 'recaptcha/rails'
  
  
end


#localization france
#require 'french_errors_localization'

#config prawn

