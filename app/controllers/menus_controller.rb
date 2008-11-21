class MenusController < ApplicationController
   before_filter :authorize_user, :except => [:recupere, :list, :show, :index]
   # uses the cookie session store (then you don't need a separate :secret)
   # protect_from_forgery :except => :recupere
   
   
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
      if current_user and Profil.find_by_id(current_user.id)
         profil = Profil.find_by_id(current_user.id)
         @affichage =  profil.style_menu
      else
         @affichage = 'semaine_style'
      end
      
      item_per_page = (@affichage == 'semaine_style') ? 10 : Menu.per_page
      
      puts 'par page :'+item_per_page.to_s
      @menus = Menu.paginate  :page => params[:page],
                              :conditions => ["title like ? and user_id like ? and menutype_id like ?",
                                       "%#{params[:tags_id]}%", 
                                       "%#{params[:user_id]}%", 
                                       "%#{params[:menutype_id]}%"],
                               :order => 'date DESC',
                               :per_page => item_per_page
       @max = item_per_page / 2       
  end
  
  def show
    @menu = Menu.find(params[:id])
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
         flash[:notice] = 'Menu was successfully created.'
         redirect_to :action => 'list'
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
         flash[:notice] = 'Menu was successfully updated.'
         redirect_to :action => 'show', :id => @menu
      else
         render :action => 'edit'
      end
      
      #gestion des ingredients
      #i_list = params[:menu_ingredients][:ingredients]
      #Ingredient.delete_all(:menu_id => @menu.id)
      #i_list.split("\r\n").each do |contenu|
      #  Ingredient.create_with_menu_id(@menu.id,contenu)
      #  puts "liste : " + contenu
      #end      
  end

  def destroy
     Tag.destroy_unused = true
     Menu.find(params[:id]).destroy
     redirect_to :action => 'list'
  end
  
   def recupere
      @tags = Menu.tag_counts(:limit => 20, :order=>'Rand()' ) #count(*) desc')
      render :partial => "tags_list", :layout => false
   end

   def user_ok?
      unless current_user 
        return false
      end
      
      unless @menu
        return true
      end
      
      if current_user.id==@menu.user_id
        return true
      else
        return false
      end
   end 
   
   def authorize_user
     unless user_ok?
       flash[:error] = "Vous n'êtes pas authorisé à afficher cette page"
       redirect_to home_path
       false
     end
   end   
   
   
  protected
   def genereTags()
      
      tag_tab = @menu.title.split
      puts 'avant'
      puts tag_tab
      @menu.tag_list=""
      #suppression des tags inferieur à 3 car.
      tag_tab.each {|w| @menu.tag_list.add(w) if w.size>3 }
      
      puts 'apres'
      puts tag_tab
      tag_tab
   end
     
   
end
