class MenutypeController < ApplicationController
  before_filter :authorize
  
  def index
    list
    render :action => 'list'
  end

  def list
    @menutypes = Menutype.paginate :page => params[:page]
  end

  def show
    @menutype = Menutype.find(params[:id])
  end

  def new
    @menutype = Menutype.new
  end

  def create
    @menutype = Menutype.new(params[:menutype])
    if @menutype.save
      flash[:notice] = 'Menu type créé correctement.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @menutype = Menutype.find(params[:id])
  end

  def update
    @menutype = Menutype.find(params[:id])
    if @menutype.update_attributes(params[:menutype])
      flash[:notice] = 'Menu type correctement mis à jour.'
      redirect_to :action => 'show', :id => @menutype
    else
      render :action => 'edit'
    end
  end

  def destroy    
    if (Menutype.find(params[:id]).destroy)
      flash[:notice] = 'Menutype supprimé correctement.'      
    end
    redirect_to menutype_path
  end
end
