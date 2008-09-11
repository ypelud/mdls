class Menu < ActiveRecord::Base
	belongs_to :menutype
	belongs_to :user
	cattr_reader :per_page
   @@per_page = 14
    acts_as_taggable
    acts_as_commentable
end
