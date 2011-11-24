class ProfilsController < ApplicationController
  before_filter :login_required
  
  def init
    @selectedMenu = 'profil'
  end 

  def edit
    @profil = Profil.find_by_id_or_init(current_user.id) 
  end    
  
  def update
    @profil = Profil.find_by_id_or_init(current_user.id) 
    if @profil.update_attributes(params[:profil])
      flash[:notice] = t("profil.update")
      redirect_to :root
    else
      redirect_to edit_user_profil_path(current_user)
    end
  end
     
end
