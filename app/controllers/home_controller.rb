class HomeController < ApplicationController

   def index      
      @tags = Menu.tag_counts(:order=>'count(*) desc')
      @menus = Menu.find(:all, :limit=>5, :order => "date DESC")
      @menuMidi = Menu.find(:all, :conditions => "menutype_id = 1 or menutype_id = 3", :limit=>7, :order => "RAND()")
      @menuSoir = Menu.find(:all, :conditions => "menutype_id = 2 or menutype_id = 3", :limit=>14, :order => "RAND()")
    
      i = 0 
      while i < 6
         mnuM = @menuMidi.at(i)
         j = 0
         while j < 14
            mnuS = @menuSoir.at(j)
            if (mnuS) and (mnuS.id == mnuM.id)
               @menuSoir.delete_at(j)
               break 
            end               
            j += 1
         end
         i += 1 
      end     
      
      i = 7
      while i < 15
        @menuSoir.delete_at(i)
        i += 1
      end
   end
   
   def sidebar
     render :partial => "sidebar"
   end
   
   def compteur
     @nbM = User.count
     @nbC = Menu.count
     render :partial => "compteur"
   end 
   
end
