#encoding: utf-8
class CommentsController < ApplicationController
  before_filter :authorize_user, :only => [:new]
  
  def new
    @menu = Menu.find(params[:id])
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    @comment.created_at = Time.now
    @menu.comments << @comment
    render :partial => "show", :locals => {:comment => @comment } 
  end
  
  def show
    @comment = Comment.find(params[:id])
    render :layout=>false  if request.xhr?
  end
  
  def list5
    @comments = Comment.find(:all, :order => "created_at desc", :limit => 3)
    render :partial => "list5"
  end
  
  def index
    @comments = Comment.find(:all)
  end  
  
private
  def authorize_user
    unless current_user
      flash[:error] = "Vous n'êtes pas authorisé à afficher cette page"
      redirect_to home_path
      false
    end
  end
  
end
