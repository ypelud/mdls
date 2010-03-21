class Menu < ActiveRecord::Base
  belongs_to :menutype
  belongs_to :user
  has_many :ingredient
  
  cattr_accessor :per_page
  @@per_page = 25
  
  acts_as_taggable
  acts_as_commentable
  
  def iui_caption
    title
  end
  
  def iui_url
    '/menus/'+to_param
  end
  
  def iui_title
    title
  end
end
