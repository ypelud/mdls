class HomeController < ApplicationController
 
   def sidebar
     render :partial => "sidebar"
   end
   
   def compteur
     @nbM = User.count
     @nbC = Menu.count
     render :partial => "compteur"
   end 
   
end
