class TagsController < ApplicationController

  def index
    @tags = Menu.tag_counts()
    respond_to do |format|
      format.html 
      format.iphone { render :layout => false }
      end    
  end
  
end