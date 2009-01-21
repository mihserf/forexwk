class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Вход, осуществлён!"
      redirect_back_or_default account_url
    else
      flash[:login_error] = "не подходит логин или пароль"
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Выход осуществлён!"
    redirect_back_or_default new_user_session_url
  end

end
