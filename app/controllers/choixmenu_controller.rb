class ChoixmenuController < ApplicationController
  before_filter :week_array
  #require 'pdf/writer'
  #require 'pdf/simpletable'

  def add
    menu_id = params[:id].split("_")[1]    
    day = 'tous' #params[:day]
    ms = 'tous' #params[:midisoir]
    menusliste = Menusliste.new

    menusliste.day = 'tous'
    menusliste.when = 'tous'
    menusliste.menu_id = menu_id      

    session[:choix].push(menusliste) 
    render :text => "#{session[:choix].length} menu(s)"
  end

  def remove
    menu_id = params[:id] 
    day = 'tous' #params[:day]
    ms = 'tous' #params[:midisoir]
    session[:choix].each do |menusliste| 
      if menusliste.menu_id=menu_id
        session[:choix].delete(menusliste) 
        break
      end
    end
    render :text => "#{session[:choix].length} menu(s)"
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
      session[:choix].push(menusliste) 
    end  
    redirect_to :root
  end

  def empty
    session[:choix] = []
    redirect_to :root
  end

end
