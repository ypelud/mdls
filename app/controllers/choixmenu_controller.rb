class ChoixmenuController < ApplicationController
  before_filter  :fill_session
  require 'pdf/writer'
  require 'pdf/simpletable'
  
  
  def list
      render :partial => "menu_list"
  end
   
  def add
      menu_id = params[:id].include?("_") ? params[:id].split("_")[1] : params[:id];
      menusliste = Menusliste.new
      
      menusliste.day = params[:day] || 0
      menusliste.when = params[:midisoir] || 0
      menusliste.menu_id = menu_id      
      session[:choix].push(menusliste) 
      render :partial => 'cart', :locals => { :day => menusliste.day, :midisoir => menusliste.when } 
  end
  
  def remove
      menu_id = params[:id] 
      day = params[:day].to_i
      ms = params[:midisoir].to_i
      session[:choix].each do |menusliste| 
        if menusliste.day==day and menusliste.when==ms and  menusliste.menu_id.to_s==menu_id
            session[:choix].delete(menusliste) 
            break
        end
      end
          
      render :partial => 'cart', :locals => { :day => day, :midisoir => ms } 
  end

  def save
  
  end
  
  def print
    fname = 'Menus_'+Time.now.to_i.to_s+'.pdf'
    send_data ChoixmenuDrawer.draw(@week,@midisoir,session[:choix]), :filename => fname, :type => "application/pdf", :disposition => 'inline'    
  end
  
  def apply
    session[:choix] = []
    planning = Planning.find(params[:id])
    planning.menuslistes.each do |menusliste|
      session[:choix].push(menusliste) 
    end  

    redirect_to :back 
  end
  
  def empty
    session[:choix] = []
    redirect_to :back 
  end
  
private
  def fill_session
    session[:choix] ||= []
  end
  
end
