class ChoixmenuController < ApplicationController
  
  def add
    menu_id = params[:id]
    
    menusliste = Menusliste.new
    menusliste.day = 'tous'
    menusliste.when = 'tous'
    menusliste.menu_id = menu_id      

    session_choix.push(menusliste) 
    render :partial => "cart"
  end

  def remove
    menu_id = params[:id] 
    session_choix.each do |menusliste| 
      if menusliste.menu_id=menu_id
        session_choix.delete(menusliste) 
        break
      end
    end
    render :text => "#{session_choix.length} menu(s)"
  end

  def save
    #do nothing
  end

  #def print
  #  fname = 'Menus_'+Time.now.to_i.to_s+'.pdf'
  #  send_data ChoixmenuDrawer.draw(@week,@midisoir,session[:choix]), :filename => fname, :type => "application/pdf", :disposition => 'inline'    
  #end

  def apply
    session[:choix] = []
    @planning = Planning.find(params[:id])
    @planning.menuslistes.each do |menusliste|
      session_choix.push(menusliste) 
    end  
    redirect_to :root
  end

  def empty
    session[:choix] = []
    redirect_to :root
  end

end
