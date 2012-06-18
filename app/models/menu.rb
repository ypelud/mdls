class Menu < ActiveRecord::Base
  belongs_to :menutype
  belongs_to :user
  
  cattr_accessor :per_page
  @@per_page = 30
  
  acts_as_taggable
  acts_as_commentable
  
  
  def before_save()
    Tag.destroy_unused = true

    tag_tab = self.title.split

    self.tag_list=""
    #suppression des tags inferieur à 3 car.
    tag_tab.each {|w| self.tag_list.add(w) if w.size>3 }
  end
  
  def self.presentation(current_user)
    #profil = Profil.find_by_id(current_user.id) if current_user 
    affichage = 'liste_style' #profil ? profil.style_menu : 'liste_style' 
    items_per_page = affichage == 'semaine_style' ? 10 : Menu.per_page
    { :affichage => affichage, :items_per_page => items_per_page}
  end
  
end
