class ChoixmenuController < ApplicationController
   
   require 'pdf/writer'
   require 'pdf/simpletable'

   def list
      session[:choix] ||= {}
      @week = 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'
      render :partial => "menu_list"
   end
   
   
  def add
      menu_id = params[:id].split("_")[1]    
      day = params[:day]
      session[:choix][day] ||= []
      if session[:choix][day].size < 2 and not session[:choix][day].include?(menu_id)
         session[:choix][day].push(menu_id)
      end
      render :partial => 'cart', :locals => { :day => day } 
  end
  
  def remove
      menu_id = params[:id] #.split("_")[1]    
      day = params[:day]      
      session[:choix][day].delete(menu_id)
      render :partial => 'cart', :locals => { :day => day } 
  end
  
  def print
    week = 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'
    semaineMidi = {}
    semaineSoir = {}
    week.each do |day|
      semaineMidi[day] = (session[:choix][day] and session[:choix][day].size > 0)? Iconv.conv('ISO-8859-1', 'UTF-8',  Menu.find(session[:choix][day][0]).title) : 'Aucun'
      semaineSoir[day] = (session[:choix][day] and session[:choix][day].size > 1)? Iconv.conv('ISO-8859-1', 'UTF-8',  Menu.find(session[:choix][day][1]).title) : 'Aucun'      
    end

    pdf = PDF::Writer.new(:orientation => :landscape)
    pdf.select_font 'Times-Roman'

    pdf.text "menusdelasemaine.com", :font_size => 18, :justification => :left
    
    table = PDF::SimpleTable.new
    table.data  = [ semaineMidi, semaineSoir ]       
    table.column_order = week
    table.font_size = 14
    table.title_gap = 10
    table.row_gap = 20
    week.each do |day|
       table.columns[day] = PDF::SimpleTable::Column.new(day) { |col|
          col.heading = day
          col.width = 100
       }
    end    
    pdf.move_pointer(30)
    table.render_on(pdf)    
    send_data pdf.render, :filename => 'menus', :type => "application/pdf"
  end

end
