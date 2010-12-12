class HomeController < ApplicationController
    
   
   def sidebar
     render :partial => "sidebar"
   end
   
   def comment
     self.class.layout 'simple'
   end
   
end
