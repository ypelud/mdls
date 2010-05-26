class Menu < ActiveRecord::Base
  belongs_to :menutype
  belongs_to :user

  validates_presence_of :menutype, :user
  validates_presence_of :title
  
  cattr_accessor :per_page
  @@per_page = 25
  
  acts_as_taggable
  acts_as_commentable

end
