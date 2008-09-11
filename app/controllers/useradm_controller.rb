class UseradmController < ApplicationController
  
  def list
    #@users = User.find(:all)
    @users = User.paginate  :page => params[:page]                                              
   end
   
end