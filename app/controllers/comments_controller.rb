class CommentsController < ApplicationController
  before_filter :require_user, :only => [:create]
  layout nil
  
  def new
    @menu = Menu.find(params[:id])
   
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.created_at = Time.now
    @menu.comments << @comment
  end
  
  def list
    @menu = Menu.find(params[:id])
    @comment = Comment.new()
    respond_to do |format| 
      format.html { render :partial => "list" }
      format.js
    end
  end
  
  
end
