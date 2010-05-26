class CommentsController < ApplicationController
  before_filter :authorize_user, :except => [:list]
  
  def create
    @menu = Menu.find(params[:id])
   
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.created_at = Time.now
    @menu.comments << @comment
    render :layout => false
  end
  
  def list
    @menu = Menu.find(params[:id])
    @comment = Comment.new()
    respond_to do |format| 
      format.html { render :partial => "list", :layout => false }
      format.js
    end
  end
  
  def list5
    debugger
    @comments = Comment(5)
    respond_to do |format| 
      format.html { render :partial => "list5", :layout => false }
      format.js
    end
  end

  def comment5
    debugger
  end
  
  def authorize_user
    unless current_user
      flash[:error] = t("comment.authorize")
      redirect_to :back
      false
    end
  end  
end
