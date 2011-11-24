class Profil < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user
  
  def self.find_by_id_or_init(id)
    profil = Profil.find_by_id(id) 
    unless profil
      profil = Profil.new
      profil.id = id 
      profil.user_id = id 
      profil.layout_name = "" #:user_style
      profil.style_menu = 'semaine_style'
      profil.save    
    end    
    profil    
  end
  
end
