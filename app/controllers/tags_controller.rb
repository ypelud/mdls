class TagsController < ApplicationController

  def recupere
    @tags = Menu.tag_counts(:limit => 20, :order=>'Rand()' ) #count(*) desc')
    render :partial => "tags_list", :layout => false
  end
  
  def index
    @tags = Menu.tag_counts()
    respond_to do |format|
      format.html 
      format.iphone { render :layout => false }
      end    
  end
  
end