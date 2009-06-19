class BrowsersController < ApplicationController

  def index
    respond_to do |format|
      format.html {redirect_to menus_url}
      format.iphone {render :text => "", :layout => true}
    end
  end
  
end