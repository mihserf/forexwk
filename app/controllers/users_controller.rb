class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:edit, :update]

  # GET /users
  # GET /users.xml
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if params[:agreement]=="true" && @user.save
      add_dealing_center
      flash[:notice] = "Аккаунт создан!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def edit
    if admin? && params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def update
    if admin?
      @user = User.find(params[:id])
    else
      @user = current_user # makes our views "cleaner" and more consistent
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

  def check_email
    result="занят"
    result="свободен" if User.find(:all, :conditions => ["email=:email",{:email => params[:value]}]).empty?
    render :inline => result
  end

  def check_login
    result="занят"
    result="свободен" if User.find(:all, :conditions => ["login=:login",{:login => params[:login]}]).empty?
    render :inline => result
  end

  def add_dealing_center
    unless params[:dealing_center][:name]==""
      params[:dealing_center][:temp]=true
      params[:dealing_center][:added_by_user]=@user.id
      @user.dealing_center = DealingCenter.new(params[:dealing_center])
      @user.save
    end
  end

end
