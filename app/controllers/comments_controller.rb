class CommentsController < ApplicationController
  def new
    @menu = Menu.find(params[:id])
   
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    @comment.created_at = Time.now
    @menu.comments <<@comment
    render :layout=>false
  end
  
  def list
    @menu = Menu.find(params[:id])
    render :partial => "list"
  end
  
  def list5
    @comments = Comment.find(:all, :order => "created_at desc", :limit => 3)
    render :partial => "list5"
  end
  
  def show
    @comment = Comment.find(:all)
  end  
end
