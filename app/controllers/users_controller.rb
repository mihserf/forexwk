class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:edit, :update]

  # GET /users
  # GET /users.xml
  def new
    @user = User.new
    @messaging_rule = MessagingRule.new
    @rules = Page.find_by_permalink("rules")
  end

  def create
    @user = User.new(params[:user])
    @messaging_rule = MessagingRule.new(params[:messaging_rule])
    @rules = Page.find_by_permalink("rules")
    @user.messaging_rule=@messaging_rule
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
    @user_tags = Article.tag_counts(:conditions => {:user_id => @user.id})
  end

  def edit
    if admin? && params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @messaging_rule = @user.messaging_rule
  end

  def update
    file_name = RAILS_ROOT + '/public/attachments/test.log'
    file1=File.new(file_name,"w")
    file1.close
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
    messaging_rule=MessagingRule.find_or_create_by_user_id(@user.id)
    messaging_rule.update_attributes(params[:messaging_rule])
    @user.save
    if @user.update_attributes(params[:user])
      add_dealing_center
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
    result="свободен" if User.find(:all, :conditions => ["login=:login",{:login => params[:value]}]).empty?
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
