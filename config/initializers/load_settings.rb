# create a config/settings.yml like this
#
# development:
# host: http://localhost:3000
# mail_to:  mail_to@localhost
# mail_from: mail_from@localhost
# super_user: root
#   
# test:
#   host: http://localhost:3000
#   mail_to:  mail_to@localhost
#   mail_from: mail_from@localhost
#   super_user: root 
#   
# production:
#   host: http://localhost:3000
#   mail_to:  mail_to@localhost
#   mail_from: mail_from@localhost
#   super_user: root 
#

APP_CONFIG = YAML::load_file(File.join(RAILS_ROOT, "config", "settings.yml"))[RAILS_ENV]