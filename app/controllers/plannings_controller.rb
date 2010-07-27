class PlanningsController < ApplicationController
  before_filter :authorize_user, :except => [:show, :index]

  def index
    list
    render :action => 'list'
  end


  def list  
    my_private_too = current_user && (!params[:user_id] || params[:user].id)
    @plannings = Planning.paginate  :page => params[:page],
      :conditions => ["(user_id like ? and public=?) or (user_id=? and 1=?)",
                      "%#{params[:user_id]}%", true,"#{current_user.id if current_user}",
                      (!params[:user_id] || User.find_by_id(params[:user_id])==current_user)?1:2],
      :order => 'created_at desc',
      :per_page => Planning.per_page    
    end

    def new
      @planning = Planning.new
    end

    def create
      Planning.transaction do 
        @planning = Planning.new(params[:planning])
        @planning.user = current_user
        @planning.save! 
        session_choix.each do |menusliste|
          menusliste = menusliste.clone if menusliste.planning
          menusliste.planning = @planning
          menusliste.save!
        end
        redirect_to :action => 'index'
      end 
    end


    def update
      Planning.transaction do 
        @planning = Planning.find(params[:id])
        @planning.save! 
        session_choix.each do |menusliste|
          menusliste.planning = @planning
          menusliste.save!
        end
        redirect_to home_path
      end 
    end

    def show    
      if params[:id]=='choix' then
        @planning = Planning.new()
        @menuslistes= session[:choix]
      else
        @planning = Planning.find(params[:id])
        @menuslistes = @planning.menuslistes      
      end
      @planning ||=[]          
    end

    def edit
      @planning = Planning.find(params[:id])
    end

    def destroy
      planning = Planning.find(params[:id])
      planning.menuslistes.each do |menusliste|
        menusliste.destroy
      end
      planning.destroy
      redirect_to :action => 'index'
    end


    def user_ok?
      @planning=Planning.find(params[:id]) if (params[:id])

      return false unless current_user    
      return true unless @planning
      return true if (current_user.id==@planning.user_id) or admin?
      false
    end 
  end
