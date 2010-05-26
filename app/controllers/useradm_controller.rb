class UseradmController < ApplicationController
  before_filter :authorize_user
   
  def list
    @users = User.paginate  :page => params[:page],
      :per_page => 100          
  end
  
private
  def user_ok?
    admin?
  end
   
end