class PlanningsController < ApplicationController
  before_filter :authorize, :except => [:list, :show, :index]

  def index
    list
    render :action => 'list'
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

      flash[:notice] = 'Planning créé correctement.'
      redirect_to plannings_path
    end 
    
   #rescue ActiveRecord::RecordInvalid => e 
   #@details.valid? # force checking of errors even if products failed 
   #render :action => :new 
   #end 
  end
  
  def show    
    @planning = Planning.find(params[:id])
  end
  
  
  def user_ok?
    return false unless current_user    
    return true unless @planning    
    return true if (current_user.id==@planning.user_id) 
    return true if admin?
    false
  end
  
end
