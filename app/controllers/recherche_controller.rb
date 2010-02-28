class RechercheController < ApplicationController
  
  def new
    @search = Recherche.new
    #@tag_cloud = Menu.calculate()
    #@tag_counts = Menu.tag_counts()
    @tags = Menu.tag_counts()
    respond_to do |format|
      format.html {render :partial => 'new'     }
      format.iphone {render :partial => 'new', :layout => false}
    end
  end

  def update
    redirect_to :controller => 'menus',  :tags_id => params[:mot]
  end

end
