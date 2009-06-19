class Menusliste < ActiveRecord::Base
  belongs_to :planning
  
  
  def iui_caption
    'test'
  end
  
  def iui_url
    '/menus/'+to_param
  end
  
  def iui_title
    "Mdls"
  end    
end
