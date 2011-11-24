class Menu < ActiveRecord::Base
  belongs_to :menutype
  belongs_to :user
  has_many :ingredient
  
  cattr_accessor :per_page
  @@per_page = 30
  
  acts_as_taggable
  acts_as_commentable
  
  
end
