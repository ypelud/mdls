class ProfilsController < ApplicationController
  before_filter :authorize_user, :init_profil
  
  def edit
    @user = current_user
  end
    
  
  def update
    if @profil.update_attributes(params[:profil])
      flash[:notice] = t("profil.update")
      redirect_to :root
    else
      redirect_to edit_user_profil_path(current_user)
    end
  end
  
  def authorize_user
     unless current_user
       flash[:error] = t("profil.authorize")
       redirect_to :back
       false
     end
  end   
   
  def init_profil
    @profil = Profil.find_by_id(current_user.id) 
    unless @profil
      @profil = Profil.new
      @profil.id = current_user.id 
      @profil.user_id = current_user.id 
      @profil.layout_name = "" #:user_style
      @profil.style_menu = 'semaine_style'
      @profil.save    
    end        
  end 

end
