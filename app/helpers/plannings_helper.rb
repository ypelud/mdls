module PlanningsHelper
  
  def listmenu(liste)
    ret = ""
    liste.each do |m| 
      @menu = Menu.find_by_id(m.menu_id) 
      #ret = ret + "<li class='ui-state-default' id='"+m.menu_id.to_s+"'>"+menu.title+" <a href='#' class='delete_mnu'>del</a></li>" if (menu!=nil)
      render :partial => 'line' if (@menu!=nil)
    end
  end
  
  def recupereJour(liste, jour)
    return liste.select{|item| item.day == jour } if jour
    []  
  end
  
end
