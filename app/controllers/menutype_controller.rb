class MenutypeController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @menutype_pages, @menutypes = paginate :menutypes, :per_page => 10
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
      flash[:notice] = 'Menutype was successfully created.'
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
      flash[:notice] = 'Menutype was successfully updated.'
      redirect_to :action => 'show', :id => @menutype
    else
      render :action => 'edit'
    end
  end

  def destroy
    Menutype.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end