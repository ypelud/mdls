class MenusController < ApplicationController
  before_filter :find_menu, :only => [:destroy, :update, :edit, :show]
  before_filter :authorize_user, :except => [:recupere, :list, :show, :index, :feed, :feedurl]
  # uses the cookie session store (then you don't need a separate :secret)
  # protect_from_forgery :except => :recupere
  
  
  def index
    list
    render :action => 'list'
  end
  
  def list    
    pres = Menu.presentation(current_user)
    @affichage = pres[:affichage]
    @menus = Menu.paginate  :page => params[:page],
    :conditions => ["title like ? and user_id like ? and menutype_id like ?",
                                       "%#{params[:tags_id]}%", 
                                       "%#{params[:user_id]}%", 
                                       "%#{params[:menutype_id]}%"],
    :order => 'date DESC',
    :per_page => pres[:items_per_page]
    @without_ul = (iphone_request? and params[:page]!=nil)
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ], :redirect_to => { :action => :list }
  
  def show
  end
  
  def new
    @menu = Menu.new
  end
  
  def create
    @menu = Menu.new(params[:menu])
    @menu.date = Time.now #pour forcer la date
    @menu.user_id = current_user.id
    
    if @menu.save
      flash[:notice] = 'Menu créé correctement.'
      redirect_to menus_path
    else
      render :action => :new
    end
  end
  
  def edit
  end
  
  def update
    @menu.date = Time.now #pour forcer la date
    
    if @menu.update_attributes(params[:menu])
      flash[:notice] = 'Menu mis à jour correctement.'
      redirect_to(@menu)
    else
      render :action => 'edit'
    end       
  end
  
  def destroy
    Tag.destroy_unused = true
    if (@menu && authorize_user && @menu.destroy)
      flash[:notice] = 'Menu supprimé correctement.'      
    end
    redirect_to menus_path
  end
  
  def recupere
    @tags = Menu.tag_counts(:limit => 20, :order=>'Rand()' ) 
    render :partial => "tags_list", :layout => false
  end
  
  def feed
    @menus = Menu.find(:all, :order => "date desc")   
  end
  
  def feedurl
    redirect_to 'http://feeds2.feedburner.com/Menusdelasemaine'
  end 
  
private
  
  def find_menu
    @menu = Menu.find(params[:id])
  end
  
  def authorize_user
    unless user_ok?
      flash[:error] = "Vous n'êtes pas authorisé à afficher cette page"
      redirect_to home_path
      false
    end
  end
  
  def user_ok?
    return false unless current_user    
    return true unless @menu    
    return true if (current_user.id==@menu.user_id) 
    return true if admin?
    false
  end 
  
end
