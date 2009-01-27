# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time
  helper_method :admin? 
  protect_from_forgery #:secret => '2d1b863b143e5467a25d7af12a48aebd'
  
  before_filter :set_user_language

  protected
  def authorize
    unless admin?
      flash[:error] = t(:authorize_page)
      redirect_to home_path
      false
    end
  end
      
  def admin?
    logged_in? && (current_user.login==APP_CONFIG['super_user']) 
  end   
  
  def set_user_language
    session[:language] ||= 'fr-FR'
    I18n.locale = session[:language]
  end
  
  
  def midisoir
    md = t("mdls.midi"),t("mdls.soir")
    return md
  end 
  
  def week
    w = t('lundi'), t('mardi'), t('mercredi'), t('jeudi'), t('vendredi'), t('samedi'), t('dimanche')
    return w
  end 
end
