class MenuController < ApplicationController
   
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
      @menus = Menu.paginate  :page => params[:page],
                              :conditions => ["title like ? and user_id like ? and menutype_id like ?",
                                       "%#{params[:tags_id]}%", 
                                       "%#{params[:user_id]}%", 
                                       "%#{params[:menutype_id]}%"]     
                                             
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
      tag_tab = @menu.title.split
      
      #suppression des tags inferieur à 3 car.
      ii = tag_tab.size - 1
      until (ii<0)
         if (tag_tab[ii].size<4)
            tag_tab.delete_at(ii)
         end
         ii -= 1
      end
      
      @menu.tag_list = tag_tab
      
      if @menu.save
         flash[:notice] = 'Menu was successfully created.'
         redirect_to :action => 'list'
      else
         render :action => 'new'
    end
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
      Tag.destroy_unused = true
      
      @menu = Menu.find(params[:id])
      @menu.date = Time.now #pour forcer la date
      @menu.tag_list = ""
      @menu.title.scan(/\w+/) {|w| @menu.tag_list.add(w) }
      if @menu.update_attributes(params[:menu])
         flash[:notice] = 'Menu was successfully updated.'
         redirect_to :action => 'show', :id => @menu
      else
         render :action => 'edit'
      end
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

   def user_ok
      if current_user 
         if current_user.id==menu.user_id
           return true
         else
           return false
         end
      else
         return false
      end 
   end 
end
