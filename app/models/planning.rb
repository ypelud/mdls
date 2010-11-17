class Planning < ActiveRecord::Base
   belongs_to :user
   has_many :menuslistes 
   
   @@per_page = 2
end
