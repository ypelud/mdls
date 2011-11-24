class TagsController < ApplicationController

  def index
    @tags = Menu.tag_counts
  end
  
end