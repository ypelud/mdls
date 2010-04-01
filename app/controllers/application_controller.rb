# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  acts_as_iphone_controller(false)
  
  helper :all, :layout # include all helpers, all the time
  helper_method :admin?, :user_ok?
  protect_from_forgery #:secret => '2d1b863b143e5467a25d7af12a48aebd'
  
  before_filter :set_user_language, :app_before_filter
  
  protected
  #gestion des autorisations
  def authorize_user
    unless user_ok?
      flash[:error] = t(:authorize_page)
      redirect_to home_path
      false
    end
  end  
  
  def user_ok?
    admin?
  end
    
  def admin?
    logged_in? && (current_user.login==APP_CONFIG['super_user']) 
  end   
  
  #gestion de la langue
  def set_user_language
    session[:language] ||= 'fr-FR'
    I18n.locale = session[:language]
  end
  
  #méthodes pour les gestions du temps
  def midisoir
    md = t("mdls.midi"),t("mdls.soir")
    return md
  end 
  
  def week
    w = t('lundi'), t('mardi'), t('mercredi'), t('jeudi'), t('vendredi'), t('samedi'), t('dimanche')
    return w
  end 
  
  def week_array
    @week = week
    if current_user and Profil.find_by_id(current_user.id) 
      profil = Profil.find_by_id(current_user.id)
      day = profil.first_day           
      deb = @week[0]
      while day and @week[0]!=day do
        dec = @week[0] 
        @week.shift
        @week.push(dec) 
        break if @week[0]==deb 
      end          
    end            
    @midisoir = midisoir
  end

  def app_before_filter    
    session[:choix] ||= []
    week_array
  end
  
end
