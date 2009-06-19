class PlanningsController < ApplicationController

  def index
    list
    respond_to do |format|
      format.html {render :action => 'list'}
      format.iphone {render :layout => false}
    end    
  end
  
  
  def list  
    @plannings = Planning.paginate  :page => params[:page],
    :conditions => ["user_id like ?",
                                       "%#{params[:user_id]}%"],
    :order => 'created_at desc',
    :per_page => Planning.per_page    
  end
  
  def new
    @planning = Planning.new
  end

  def create
    Planning.transaction do 
      @planning = Planning.new(params[:planning])
      @planning.user_id = current_user.id
      @planning.save! 
      session[:choix].each do |@menusliste|
        @menusliste.planning = @planning
        @menusliste.save!
      end
      redirect_to :action => 'list'
    end 
    
   #rescue ActiveRecord::RecordInvalid => e 
   #@details.valid? # force checking of errors even if products failed 
   #render :action => :new 
   #end 
  end
  
  def show    
    puts params[:id]
    if params[:id]=='choix' then
      @planning = Planning.new()
      @menuslistes= session[:choix]
    else
      @planning = Planning.find(params[:id])
      @menuslistes = @planning.menuslistes      
    end
    @planning ||=[]
    week_array    
    respond_to do |format|
      format.html 
      format.iphone {render :layout => false}
    end       
  end
  
end
