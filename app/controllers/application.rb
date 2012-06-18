# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include MdlsSystem
  
  helper :all # include all helpers, all the time
  helper_method :admin? 
  protect_from_forgery #:secret => '2d1b863b143e5467a25d7af12a48aebd'
  
  before_filter :set_user_language
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
    
  def set_user_language
    session[:language] ||= 'fr-FR'
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
