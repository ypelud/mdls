class ProfilController < ApplicationController
  before_filter :authorize_user
  
  def edit
    unless Profil.find_by_id(current_user.id)
      @profil = Profil.new
      @profil.id = current_user.id 
      @profil.user_id = current_user.id 
      @profil.layout_name = 'application'
      @profil.style_menu = 'semaine_style'
      @profil.save    
    end
    
    @profil = Profil.find(current_user)
  end
    
  
  def update
    @profil = Profil.find(params[:id])
    if @profil.update_attributes(params[:profil])
      flash[:notice] = 'Les options ont été correctement enregistrées.'
      redirect_to home_path
    else
      render :action => 'edit'
    end
  end
  
  def authorize_user
     unless current_user
       flash[:error] = "Vous n'êtes pas authorisé à afficher cette page"
       redirect_to home_path
       false
     end
   end   
   
end
