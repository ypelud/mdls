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
    planning = Planning.find_by_id(planning_id)
  	if planning and current_user and planning.user_id==current_user.id then
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
      '<a class="button" href="/plannings/new">TODO choixmenu_create</a>'
    end
  end
  
  def cartcount
    return "Menu#{session_choix.length>1?'s':''} de la semaine (#{session[:choix].length})" if session_choix.length>0
    'aucun menu'
  end



end


