class UseradmController < ApplicationController
  before_filter :authorize
   
  def list
    #@users = User.find(:all)
    @users = User.paginate  :page => params[:page]                                              
   end
   
end