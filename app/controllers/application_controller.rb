class ApplicationController < ActionController::Base
  
  protect_from_forgery
  layout 'application'
  
  helper :all # include all helpers, all the time
  helper_method :admin?, :session_choix, :current_user, :current_user_session
  before_filter :init
  
private
  def init
    @selectedMenu ||= 'menu'    
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
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

  def authorize_user 
    unless user_ok? || admin?
      flash[:error] = t(:authorize_page) 
      redirect_to :root 
      false 
    end 
  end
  
  def admin?
    current_user && (current_user.login==APP_CONFIG['super_user']) 
  end
  
  #false by default
  def user_ok?
    false
  end

  def session_choix(jour=nil)
    return session[:choix].select{|item| item.day == jour } if jour
    session[:choix] ||= []
  end

  
end
