class Planning < ActiveRecord::Base
   belongs_to :user
   has_many :menuslistes  
   
  def iui_caption
    name
  end
  
  def iui_url
    '/plannings/'+to_param
  end
  
  def iui_title
    "Mdls"
  end
end
