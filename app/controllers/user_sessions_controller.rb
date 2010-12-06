class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
    respond_to do |format| 
      format.html { render :partial => 'new', :layout => false }
      format.js
    end
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = t("logged_in")
      redirect_to :root
    else
      flash[:error] = t("login_failed")
      redirect_to :root
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = t("logged_out")
    redirect_to :root
  end
end
