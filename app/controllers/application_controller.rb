class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include MdlsSystem

  protect_from_forgery
  
  
  helper :all # include all helpers, all the time
  helper_method :admin? 
  
  before_filter :init_all
  before_filter :adjust_format_for_iphone
  
protected
  def authorize
    unless (self.respond_to?(:user_ok?, true) && user_ok?) || admin? 
      flash[:error] = t(:authorize_page)
      redirect_to home_path
      false
    end
  end
  
  def admin?
    logged_in? && (current_user.login==APP_CONFIG['super_user']) 
  end   
    
  def init_all
    session[:language] ||= 'fr-FR'
    session[:choix]||=[]
    I18n.locale = session[:language]
  end
  
  
  private
  # Set iPhone format if request to iphone.trawlr.com
  def adjust_format_for_iphone
    request.format = :iphone if iphone_request?
    #self.class.layout(nil) if iphone_request? 
  end
  
  # Return true for requests to iphone.trawlr.com
  def iphone_request?
    return (request.subdomains.first == "iphone" || params[:format] == "iphone")
  end
  
  
  
end
