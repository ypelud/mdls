class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_admin, :only => [:index, :compteur]
     
  def init
    @selectedMenu = 'user'
  end
   
  
  # render new.rhtml
  def new
    @user = User.new
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = t("signup_complete")
      redirect_to root_url
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = t("user.update_ok")
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
  def index
    @users = User.paginate  :page => params[:page],
      :per_page => 100          
  end  
  
  def compteur
     @nbM = User.count
     @nbC = Menu.count
     render :partial => "compteur"
   end
  
  def language
    code = params[:code] || 'fr-FR'
    I18n.default_locale = code
    flash[:notice] = t("welcome")
    redirect_to root_url
    #redirect_back_or_default :back  
  end
  

end
