class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  helper :all # include all helpers, all the time

  before_filter :set_user_language, :app_before_filter, :except => [:current_user_session, :current_user]
    
  helper_method :admin?, :current_user, :current_user_session

private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

protected
  
  #gestion des autorisations
  def authorize_user
    unless user_ok?
      flash[:error] = t(:authorize_page)
      redirect_to :root
      false
    end
  end
  
  def user_ok?
    true
  end
    
  def admin?
    current_user && (current_user.login==APP_CONFIG['super_user']) 
  end   
  
  #gestion de la langue
  def set_user_language
    #session[:language] ||= 'fr-FR'
    #I18n.locale = session[:language]
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
