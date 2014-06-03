#encoding: utf-8
class ProfilController < ApplicationController
  before_filter :authorize
  
  def edit
    unless @profil = Profil.find_by_id(current_user.id)
      @profil = Profil.new
      @profil.id = current_user.id 
      @profil.user_id = current_user.id 
      @profil.layout_name = :user_style
      @profil.style_menu = 'semaine_style'
      if !@profil.save    
        flash[:error] = 'Il y a eu une erreur dans la création du profil.'        
      end
    end
  end
    
  
  def update
    if @profil = Profil.find_by_id(current_user.id) 
      if @profil.update_attributes(params[:profil])
        flash[:notice] = 'Les options ont été correctement enregistrées.'        
      else
        flash[:error] = 'Les options n''ont pas été correctement enregistrées.'              
      end
    end
    redirect_to home_path
  end
  
private

 def user_ok?
   return false unless current_user    
   true
 end
   
end
