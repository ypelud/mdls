module ChoixmenuHelper

  def planning_id
    unless session[:choix]==[]
      menuliste = session[:choix][0]
      menuliste.planning_id
    else
      0
    end
  end
  
  def link_to_save_planning
  	if planning_id>0 and current_user and Planning.find(planning_id).user_id==current_user.id then
	  '<a class="button" href="/plannings/edit/'+planning_id.to_s+'">Sauvegarder</a>'
	end
  end
  
  def link_to_duplicate_planning
    if current_user then
	  '<a class="button" href="/plannings/new">Dupliquer</a>'
    end
  end
  
  def link_to_create_planning
    if session[:choix]==[] and current_user then
      '<a class="button" href="/plannings/new">Créer</a>'
    end
  end

end


