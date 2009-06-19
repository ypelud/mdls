class MenusController < ApplicationController
  before_filter :authorize_user, :except => [:recupere, :show, :index, :feed, :feedurl, :alpha]
  # uses the cookie session store (then you don't need a separate :secret)
  # protect_from_forgery :except => :recupere
  
  
  def index
    respond_to do |format|
      format.html do
        list
      end
      format.iphone do
        if params[:alpha]
          @alpha = params[:alpha]
          @menus = Menu.all(:conditions => ["title like ? or title like ? or title like ?",
                                       "#{params[:alpha][0,1]}%","#{params[:alpha][1,1]}%","#{params[:alpha][2,1]}%"])
        else
          @replace = params[:replace]
          @menus = Menu.paginate  :page => params[:page],
          :conditions => ["title like ? and user_id like ? and menutype_id like ?",
                                       "%#{params[:tags_id]}%", 
                                       "%#{params[:user_id]}%", 
                                       "%#{params[:menutype_id]}%"],
          :order => 'date DESC' , 
          :per_page => 5          
        end
        render :layout => false
      end
    end
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
  :redirect_to => { :action => :index }
  
  def list    
    
    profil = Profil.find_by_id(current_user.id) if current_user 
    @affichage = profil ? profil.style_menu : 'semaine_style' 
    items_per_page = @affichage == 'semaine_style' ? 10 : Menu.per_page
    @menus = Menu.paginate  :page => params[:page],
    :conditions => ["title like ? and user_id like ? and menutype_id like ?",
                                       "%#{params[:tags_id]}%", 
                                       "%#{params[:user_id]}%", 
                                       "%#{params[:menutype_id]}%"],
    :order => 'date DESC',
    :per_page => items_per_page  
  end
  
  def show
    @menu = Menu.find(params[:id])
    respond_to do |format|
      format.html       
      format.iphone {render :layout => false }
    end
  end
  
  def new
    @menu = Menu.new
  end
  
  def create
    @menu = Menu.new(params[:menu])
    @menu.date = Time.now #pour forcer la date
    @menu.user_id = current_user.id
    genereTags()
    
    if @menu.save
      flash[:notice] = 'Menu créé correctement.'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end
  
  def edit
    @menu = Menu.find(params[:id])
    authorize_user
  end
  
  def update
    Tag.destroy_unused = true
    
    @menu = Menu.find(params[:id])
    @menu.date = Time.now #pour forcer la date
    genereTags()
    
    if @menu.update_attributes(params[:menu])
      flash[:notice] = 'Menu mis à jour correctement.'
      redirect_to :action => 'show', :id => @menu
    else
      render :action => 'edit'
    end       
  end
  
  def destroy
    Tag.destroy_unused = true
    Menu.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
  
  
  
  def user_ok?
    return false unless current_user    
    return true unless @menu    
    return true if (current_user.id==@menu.user_id) or admin?
    false
  end 
  
  def authorize_user
    unless user_ok?
      flash[:error] = "Vous n'êtes pas authorisé à afficher cette page"
      redirect_to "/"
      false
    end
  end   
  
  
  def feed
    @menus = Menu.find(:all, :order => "date desc")   
  end
  
  def feedurl
    redirect_to 'http://feeds2.feedburner.com/Menusdelasemaine'
  end 
  
  protected
  def genereTags()      
    tag_tab = @menu.title.split
    @menu.tag_list=""
    #suppression des tags inferieur � 3 car.
    tag_tab.each {|w| @menu.tag_list.add(w) if w.size>3 }
    tag_tab
  end
  
  
end
