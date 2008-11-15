# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time
  helper_method :admin? , :user_style
  protect_from_forgery #:secret => '2d1b863b143e5467a25d7af12a48aebd'
  
  
  protected
  def authorize
    unless admin?
      flash[:error] = "Vous n'êtes pas authorisé à afficher cette page"
      redirect_to home_path
      false
    end
  end
      
  def admin?
    logged_in? && (current_user.login==APP_CONFIG['super_user']) 
  end  
 
  def user_style
      #if current_user and Profil.find_by_id(current_user.id) 
      #   profil = Profil.find_by_id(current_user.id)
      #   profil.layout_name
      #else
         'Harvest' #'default' #CitrusIsland'
      #end      
  end  
  
end
