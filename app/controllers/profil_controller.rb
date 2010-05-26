class ProfilController < ApplicationController
  before_filter :authorize_user
  
  def edit
    unless Profil.find_by_id(current_user.id)
      @profil = Profil.new
      @profil.id = current_user.id 
      @profil.user_id = current_user.id 
      @profil.layout_name = "" #:user_style
      @profil.style_menu = 'semaine_style'
      @profil.save    
    end
        
    @profil = Profil.find(current_user)
  end
    
  
  def update
    @profil = Profil.find(params[:id])
    if @profil.update_attributes(params[:profil])
      flash[:notice] = t(profil.update)
      redirect_to :back
    else
      render :action => 'edit'
    end
  end
  
  def authorize_user
     unless current_user
       flash[:error] = t("profil.authorize")
       redirect_to :back
       false
     end
   end   
   
end
