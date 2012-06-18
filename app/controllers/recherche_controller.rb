class RechercheController < ApplicationController
  
  def new
    render :partial => 'new'
  end
  
  def find
    redirect_to :controller => 'menus', :action => 'index', :tags_id => params[:mot]
  end
end
