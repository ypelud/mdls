class MenutypesController < ApplicationController
  before_filter :authorize_user
  before_filter :init
  
  def init
    @selectedMenu = 'type'
  end
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create ],
         :redirect_to => :menutypes_url

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
      flash[:notice] = t("menutype.create")
      redirect_to menutypes_url
    else
      render :action => :new
    end
  end

  def edit
    @menutype = Menutype.find(params[:id])
  end

  def update
    @menutype = Menutype.find(params[:id])
    if @menutype.update_attributes(params[:menutype])
      flash[:notice] = t("menutype.update")
      redirect_to menutype_path(@menutype)
    else
      render :action => :edit
    end
  end

  def destroy
    Menutype.find(params[:id]).destroy
    redirect_to menutypes_url
  end
  
end
