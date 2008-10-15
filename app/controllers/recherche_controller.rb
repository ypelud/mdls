class RechercheController < ApplicationController
  
  def new
    render :partial => 'new'
  end
  
  def find
    redirect_to :controller => 'menu', :action => 'list', :tags_id => params[:mot]
  end
end
