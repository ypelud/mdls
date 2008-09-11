class CommentController < ApplicationController
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
   end
end
