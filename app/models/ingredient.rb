class Ingredient < ActiveRecord::Base


  def self.create_with_menu_id(menu_id, contenu)
    create(:menu_id => menu_id, :contenu => contenu)
  end
  
end
