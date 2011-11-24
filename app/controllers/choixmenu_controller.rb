class ChoixmenuController < ApplicationController
  
  def add
    addMenu(params)
    render :partial => "cart"
  end
  
  def addAll
    session[:choix] = [] if params["empty"]
    
    fields = JSON(params[:fields])
    fields.each do |param|
      addMenu(param)
    end
    render :partial => "cart"
  end


  def addMenu(param)
    menu_id = param["id"].split("_")[1]
    day = param["day"]

    m = Menusliste.new
    m.day = (day) ? day : 0
    m.when = 0
    m.menu_id = menu_id     
    session_choix.push(m)
  end

  
  def index
    render :partial => "cart"
  end

  def remove
    menu_id = params[:id] 
    session_choix.each do |menusliste| 
      if menusliste.menu_id==menu_id
        session_choix.delete(menusliste) 
        break
      end
    end
    render :text => "#{session_choix.length} menu(s)"
  end

  def save
    p_name = params[:name]
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
