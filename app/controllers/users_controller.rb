class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def errors
  end
 
  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      #redirect_to :controller => 'emailer', :action => 'thanksuser'
      flash[:notice] = "Merci pour votre inscription !"
      redirect_back_or_default('/')
    else
      self.class.layout 'simple'
      render :action => 'errors'
    end
  end

  def activate
    self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate
      flash[:notice] = "Enregistrement complet !"
    end
    redirect_back_or_default('/')
  end
  
  
   def forgot
     if request.post?
       user = User.find_by_email(params[:user][:email])
       if user
         user.create_reset_code
         flash[:notice] = "Un code de réinitialisation à été envoyé à  #{user.email}"
       else
         flash[:notice] = "#{params[:user][:email]} n'existe pas"
       end
       redirect_back_or_default('/')
     end
   end
   
   def reset
     @user = User.find_by_reset_code(params[:reset_code]) unless params[:reset_code].nil?
     if request.post?
      if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
         self.current_user = @user
         current_user.delete_reset_code
         current_user.activate unless current_user.active?
         flash[:notice] = "Mot de passe réinitialisé pour #{@user.email}"
         redirect_back_or_default('/')
       else
         self.class.layout 'simple'
         render :action => 'errors'
       end
     end
   end
   
   def language
     code = params[:code] || 'fr-FR'
     session[:language] = code
     redirect_to :back  
   end
end
