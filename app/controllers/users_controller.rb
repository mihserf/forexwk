class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  # GET /users
  # GET /users.xml
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Аккаунт создан!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def show
    if admin? && params[:id]
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
  end

  def edit
    if admin?
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
  end

  def update
    if admin?
      @user = User.find(params[:id])
    else
      @user = @current_user # makes our views "cleaner" and more consistent
    end
    unless params[:change_password]=="1"
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if params[:user][:password]==@user.password then params[:user][:password_confirmation]=@user.password end
    if @user.update_attributes(params[:user])
      flash[:notice] = "Аккаунт обновлён!"
      redirect_to (admin? ? user_url(@user) : account_url)
    else
      render :action => :edit
    end
  end

end
