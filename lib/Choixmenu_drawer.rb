class ChoixmenuDrawer
  def self.draw(weeks,midisoirs,menuslistes)
    semaine = []

    weeks.each do |day| 
      midisoirs.each do |ms|        
          menuslistes.each do |menusliste|
            if weeks[menusliste.day]==day and midisoirs[menusliste.when]==ms 
              semaine[midisoirs.index(ms)] ||= {}
              semaine[midisoirs.index(ms)][day] ||= ''
              semaine[midisoirs.index(ms)][day] += ' ' unless semaine[midisoirs.index(ms)][day] == ''            
              semaine[midisoirs.index(ms)][day] += Iconv.conv('ISO-8859-1', 'UTF-8',  Menu.find(menusliste.menu_id).title)             
          end 
        end 
      end
    end

    pdf = PDF::Writer.new(:orientation => :landscape)
    pdf.select_font 'Times-Roman'

    pdf.text "menusdelasemaine.com", :font_size => 18, :justification => :left
    
    table = PDF::SimpleTable.new
    table.data  = semaine
    table.column_order = weeks
    table.font_size = 14
    table.title_gap = 10
    table.row_gap = 20
    weeks.each do |day|
       table.columns[day] = PDF::SimpleTable::Column.new(day) { |col|
          col.heading = day
          col.width = 100
       }
    end    
    pdf.move_pointer(30)
    table.render_on(pdf)   
    pdf.render
  end
end