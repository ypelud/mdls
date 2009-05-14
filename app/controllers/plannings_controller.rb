class PlanningsController < ApplicationController

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
      puts @planning
      session[:choix].each do |@menusliste|
        puts @menusliste
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
    @planning = Planning.find(params[:id])
    week_array    
  end
  
  
  
  
end
