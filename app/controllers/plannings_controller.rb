class PlanningsController < ApplicationController
  before_filter :authorize_user, :except => [:show, :index, :move, :new]
  before_filter :init
  
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
    Planning.transaction do 
      @planning = Planning.find(params[:id])      
      @planning.update_attributes(params[:planning])
      @planning.save! 
      save_planning_menus(params[:fields])
    end
    render :text => "OK"
    #redirect_to home_path
  end

  def save_planning_menus(fields = [])
    @planning.menuslistes.each do |menusliste|
      menusliste.destroy
    end      
    fields.each do |jour|
      indice = jour[0].split("_")[1]
      jour[1].each do |menu|
        m = Menusliste.new
        m.day = indice
        m.menu_id = menu[1].to_i
        m.planning = @planning
        m.save!
      end
    end
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
  
  def user_ok?
    @planning=Planning.find(params[:id]) if (params[:id])
  
    return false unless current_user    
    return true unless @planning
    return true if (current_user.id==@planning.user_id) or admin?
    false
  end 

    
  end
