class Planning < ActiveRecord::Base
   belongs_to :user
   has_many :menuslistes  
end
