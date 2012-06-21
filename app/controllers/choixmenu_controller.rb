class ChoixmenuController < ApplicationController
  before_filter  :fill_session
  require 'pdf/writer'
  require 'pdf/simpletable'
  
  
  def list
      render :partial => "menu_list"
  end
   
  def add
      menu_id = params[:id].split("_")[1]    
      day = params[:day]
      ms = params[:midisoir]
      menusliste = Menusliste.new
      
      menusliste.day = @week.index(day)
      menusliste.when = @midisoir.index(ms)
      menusliste.menu_id = menu_id      

      session[:choix].push(menusliste) 
      render :partial => 'cart', :locals => { :day => day, :midisoir => ms } 
  end
  
  def remove
      menu_id = params[:id] 
      day = params[:day]
      ms = params[:midisoir]
      session[:choix].each do |menusliste| 
        puts "#{menusliste.day}==#{@week.index(day)}"
        puts "#{menusliste.when}==#{@midisoir.index(ms)}"
        puts "#{menusliste.menu_id}==#{menu_id}"
        if menusliste.day==@week.index(day) and menusliste.when==@midisoir.index(ms) and  menusliste.menu_id.to_s==menu_id
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
