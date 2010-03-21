module MenuHelper
   
  def options_list
    options= {} 
    options[:as_replace] = @replace 
    options[:more] = ListModel.new(nil, "Voir plus", menus_path(:page => @menus.next_page, :replace => true), "Menusdelasemaine" ) if @menus.next_page 
    options
  end

  def menu_position
    @position ||= 1
    if (@position%2==0)
      res = 'even' 
    else
      res = ''
    end
    @position=@position+1
    res
  end
end
