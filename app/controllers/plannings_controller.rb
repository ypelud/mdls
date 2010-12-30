class PlanningsController < ApplicationController
  before_filter :login_required, :except => [:show, :index, :move, :new]
  
  def init
    @selectedMenu = 'planning'
  end
  
  def index
    my_private_too = current_user && (!params[:user_id] || params[:user].id)
    @plannings = Planning.paginate  :page => params[:page],
      :conditions => ["(user_id like ? and public=?) or (user_id=? and 1=?)",
                      "%#{params[:user_id]}%", true,"#{current_user.id if current_user}",
                      (!params[:user_id] || User.find_by_id(params[:user_id])==current_user)?1:2],
      :order => 'created_at desc'
  end

  def new
    @planning = Planning.new
    @liste = session_choix
    session[:menuslistes] = nil
  end
  
  def create
    Planning.transaction do 
      @planning = Planning.new(params[:planning])
      @planning.user = current_user
      @planning.save! 
      monChoix.each do |menusliste|
        menusliste = menusliste.clone if menusliste.planning
        menusliste.planning = @planning
        menusliste.save!
      end
    end 
    redirect_to :action => 'index'
  end
  
  
  def update
    debugger
    Planning.transaction do 
      @planning = Planning.find(params[:id])      
      @planning.update_attributes(params[:planning])
      @planning.save! 
      @planning.menuslistes.each do |menusliste|
        menusliste.destroy
      end      
      fields = JSON(params[:fields])
      fields.each do |param|
        menu_id = param["id"].split("_")[1]
        day = param["day"]

        m = Menusliste.new
        m.day = (day) ? day : 0
        m.when = 0
        m.menu_id = menu_id
        m.planning = @planning
        m.save!
      end    
    end
    render :text => "OK"
  end
  
  
  def show    
    @planning = Planning.find(params[:id])
    @liste = @planning.menuslistes     
    session[:menuslistes] = []
    @planning.menuslistes.each do |menusliste|
      session[:menuslistes].push(menusliste)   
    end              
  end
  
  def edit
    @planning = Planning.find(params[:id])
    @liste = @planning.menuslistes                      
    session[:menuslistes] = []
    @planning.menuslistes.each do |menusliste|
      session[:menuslistes].push(menusliste)      
    end           
  end
  
  def destroy
    planning = Planning.find(params[:id])
    planning.menuslistes.each do |menusliste|
      menusliste.destroy
    end
    planning.destroy
    redirect_to :action => 'index'
  end
  
  def move
    fields = JSON(params[:fields])
    guid = params[:guid] 
    day = params[:day]  
    monChoix.each do |menusliste| 
      if menusliste.guid == Guid.from_s(guid)
        menusliste.day = day
        break
      end
    end
    render :text => "OK"    
  end
  
  def monChoix
     return session[:menuslistes] if session[:menuslistes]
     session_choix
  end
  
  def authorized?
    @planning=Planning.find(params[:id]) if (params[:id])
    return true unless @planning
    return false unless current_user
    return true if (current_user.id==@planning.user_id) or admin?
    false
  end 

    
  end
