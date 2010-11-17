class MenusController < ApplicationController
  before_filter :authorize_user, :except => [:show, :index, :feed, :feedurl]
  before_filter :init
  
  def init
    @selectedMenu = 'menu'
  end
  
  def index
    @menus = Menu.paginate  :page => params[:page],
      :conditions => ["title like ? and user_id like ? and menutype_id like ?",
                      "%#{params[:tags_id]}%", 
                      "%#{params[:user_id]}%", 
                      "%#{params[:menutype_id]}%"],
    :order => 'date DESC'
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
  :redirect_to => { :action => :index }
  
  
  def show
    @menu = Menu.find(params[:id])
  end
  
  def new
    @menu = Menu.new
  end
  
  def create    
    @menu = Menu.new(params[:menu])
    @menu.date = Time.now #pour forcer la date
    @menu.user = current_user
    genereTags()
    
    if @menu.save
      flash[:notice] = t('menus.create')
      redirect_to menus_url
    else
      render :new
    end
  end
  
  def edit
    @menu = Menu.find(params[:id])
  end
  
  def update
    Tag.destroy_unused = true
    
    @menu = Menu.find(params[:id])
    @menu.date = Time.now #pour forcer la date
    genereTags()
    if @menu.update_attributes(params[:menu])
      flash[:notice] = t('menus.update')
      redirect_to menu_path(@menu)
    else
      render :edit
    end       
  end
  
  def destroy
    Tag.destroy_unused = true
    Menu.find(params[:id]).destroy
    redirect_to menus_url
  end
    
  def feed
    @menus = Menu.find(:all, :order => "date desc")   
  end
  
  def feedurl
    redirect_to 'http://feeds2.feedburner.com/Menusdelasemaine'
  end 
  
protected
  def user_ok?
    @menu = Menu.find_by_id(params[:id]) if params[:id]
    return false unless current_user    
    return true unless @menu    
    return true if (current_user.id==@menu.user_id) or admin?
    false
  end 

  def genereTags()      
    tag_tab = @menu.title.split
    @menu.tag_list=""
    #suppression des tags inferieur à 3 car.
    tag_tab.each {|w| @menu.tag_list.add(w) if w.size>3 }
    tag_tab
  end
  
  
end
