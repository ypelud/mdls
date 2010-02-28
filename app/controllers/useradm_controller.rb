class UseradmController < ApplicationController
  before_filter :authorize_user
   
  def list
    #@users = User.find(:all)
    @users = User.paginate  :page => params[:page],
    :per_page => 100          
    
    @NbUser = User.count                                   
   end
   
end