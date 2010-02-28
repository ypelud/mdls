class PlanningsController < ApplicationController
  before_filter :authorize_user, :except => [:show, :index]

  def index
    list
    respond_to do |format|
      format.html {render :action => 'list'}
      format.iphone {render :layout => false}
    end    
  end
  
  
  def list  
    if current_user!=nil then
	  actual_id=current_user.id
	else
	  actual_id=""
	end
    @plannings = Planning.paginate  :page => params[:page],
    :conditions => ["(user_id like ? and public=true) or (user_id=? and ?)",
                                       "%#{params[:user_id]}%",
                                       "#{actual_id}",
                                       (params[:user_id]==actual_id.to_s|| !params[:user_id])?true:false],
    :order => 'created_at desc',
    :per_page => Planning.per_page    
  end
  
  def new
    @planning = Planning.new
  end

  def create
    Planning.transaction do 
      @planning = Planning.new(params[:planning])
      @planning.user_id = current_user.id
      @planning.save! 
      session[:choix].each do |menusliste|
        if menusliste.planning then
          menusliste = menusliste.clone
        end
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
      session[:choix].each do |@menusliste|
        @menusliste.planning = @planning
        @menusliste.save!
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
    week_array    
    respond_to do |format|
      format.html 
      format.iphone {render :layout => false}
    end       
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
    @planning=Planning.find(params[:id])
	
    return false unless current_user    
    return true unless @planning
    return true if (current_user.id==@planning.user_id) or admin?
    false
  end 
end
