class ApplicationController < ActionController::Base
#  include AuthenticatedSystem
  
  protect_from_forgery
  layout 'application'
  
  helper :all # include all helpers, all the time
  helper_method :admin?, :session_choix,  :current_user_session, :current_user
  before_filter :init
  
  # Initialise le nom du menu de la barre de navigation.
  # Permet d'identifier le menu séléctionné.
  #
  # voir ApplicationHelper#selected_menu
  def init
    @selectedMenu ||= 'menu'    
  end
  
  # Permet de gérer un filtre pour s'assurer de la connexion d'un utilisateur.
  #
  # Redirection vers l'écran de connexion en cas d'échec
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end
  
  # Permet de gérer un filtre pour s'assurer qu'aucun utilisateur n'est connecté.
  #
  # Redirection vers l'écran d'inscription en cas d'échec
  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end
  
  # Permet de gérer un filtre pour s'assurer de la connexion d'un administrateur
  #
  # Redirection vers l'écran d'accueil en cas d'échec
  def require_admin
    unless admin?
      store_location
      flash[:notice] = "You must be admin in to access this page"
      redirect_to :root
      return false
    end
  end  

protected
  def login_required
    authorized? || access_denied
  end
  
  def authorized?
    admin?
  end
  
private
  def access_denied 
    flash[:error] = t(:authorize_page) 
    redirect_to :root 
    false 
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  # Définie la session courante
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  # Valide la connexion d'un administrateur
  def admin?
    current_user && (current_user.login==APP_CONFIG['super_user']) 
  end
  
  def session_choix(jour=nil)
    return session[:choix].select{|item| item.day == jour } if jour
    session[:choix] ||= []
  end
    
end
