class ChoixmenuController < ApplicationController
  before_filter :week_array
  require 'pdf/writer'
  require 'pdf/simpletable'
  
  
  def list
      session[:choix] ||= {}
      render :partial => "menu_list"
  end
   
  def add
      menu_id = params[:id].split("_")[1]    
      day = params[:day]
      midisoir = params[:midisoir]
      session[:choix][day+midisoir] ||= []
      session[:choix][day+midisoir].push(menu_id) if not session[:choix][day+midisoir].include?(menu_id)
      render :partial => 'cart', :locals => { :day => day, :midisoir => midisoir } 
  end
  
  def remove
      menu_id = params[:id] 
      day = params[:day]      
      midisoir = params[:midisoir]
      session[:choix][day+midisoir].delete(menu_id)
      render :partial => 'cart', :locals => { :day => day, :midisoir => midisoir } 
  end

  def print
    semaine = []

    @week.each do |day| 
      $midisoir.each do |midisoir|
        if session[:choix][day+midisoir]
          session[:choix][day+midisoir].each do |menu_id|
            semaine[$midisoir.index(midisoir)] ||= {}
            semaine[$midisoir.index(midisoir)][day] ||= ''
            semaine[$midisoir.index(midisoir)][day] += ' ' unless semaine[$midisoir.index(midisoir)][day] == ''            
            semaine[$midisoir.index(midisoir)][day] += Iconv.conv('ISO-8859-1', 'UTF-8',  Menu.find(menu_id).title)             
          end 
        end 
      end
    end

    pdf = PDF::Writer.new(:orientation => :landscape)
    pdf.select_font 'Times-Roman'

    pdf.text "menusdelasemaine.com", :font_size => 18, :justification => :left
    
    table = PDF::SimpleTable.new
    table.data  = semaine
    table.column_order = @week
    table.font_size = 14
    table.title_gap = 10
    table.row_gap = 20
    @week.each do |day|
       table.columns[day] = PDF::SimpleTable::Column.new(day) { |col|
          col.heading = day
          col.width = 100
       }
    end    
    pdf.move_pointer(30)
    table.render_on(pdf)    
    send_data pdf.render, :filename => 'menus', :type => "application/pdf"
  end
  
  protected
    def week_array
      @week = $week
      if current_user and Profil.find_by_id(current_user.id) 
         profil = Profil.find_by_id(current_user.id)
         day = profil.first_day         
         while day and @week[0]!=day  do
           dec = @week[0] 
           @week.shift
           @week.push(dec)
         end          
      end      
      
      @midisoir = $midisoir
    end
end
