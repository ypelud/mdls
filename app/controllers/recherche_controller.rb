class RechercheController < ApplicationController
  
  def new
    @search = Recherche.new
    #@tag_cloud = Menu.calculate()
    #@tag_counts = Menu.tag_counts()
    #@tags = Menu.tag_counts()
    render :partial => 'new'     
  end

  def update
    redirect_to :controller => 'menus',  :tags_id => params[:mot]
  end

end
