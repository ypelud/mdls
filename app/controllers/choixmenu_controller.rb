class ChoixmenuController < ApplicationController

   def list
      session[:choix] ||= {}
      render :partial => "menu_list"
   end
   
   
  def add
      menu_id = params[:id].split("_")[1]    
       session[:choix][menu_id] = 
         session[:choix].include?(menu_id) ?  
         session[:choix][menu_id]+1 : 1
      render :partial => 'cart'
  end
  
  def remove
      menu_id = params[:id].split("_")[1]       
      session[:choix].delete(menu_id)
      render :partial => 'cart'      
  end

  
end
