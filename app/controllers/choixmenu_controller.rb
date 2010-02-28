class ChoixmenuController < ApplicationController
  before_filter :week_array
  require 'pdf/writer'
  require 'pdf/simpletable'
  
  
  def list
      session[:choix] ||= []
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
        if @week[menusliste.day]==day and @midisoir[menusliste.when]==ms and menusliste.menu_id=menu_id
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
    @planning = Planning.find(params[:id])
    @planning.menuslistes.each do |menusliste|
      session[:choix].push(menusliste) 
    end  

    respond_to do |format|
      format.html {redirect_to home_path}
      format.iphone {render :text => "", :layout => false}
    end    
  end
  
  def empty
    session[:choix] = []
    respond_to do |format|
      format.html {redirect_to home_path}
      format.iphone {render :text => "", :layout => false}
    end    
  end
  
  def addform
     @options = ''
     week.each do |w| 
       @options += '<option>'+w+'</option>'
       
     end
     respond_to do |format|
      format.html {redirect_to home_path}
      format.iphone {render  :layout => false}
    end        
  end
  
  
end
