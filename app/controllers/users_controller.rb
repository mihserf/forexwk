class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:edit, :update]
  
  def index
    @users = User.paginate(:page => params[:page], :per_page => 10, :order=>"login")
  end
  
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

    if params[:agreement]=="true" && @user.signup!(params)
      @user.deliver_activation_instructions!
      rating_for_choosing_dealing_center(new_user=true)
      add_dealing_center
      flash[:notice] = "Ваш аккаунт создан. Пожалуйста, следуйте инструкциям, высланным на Ваш email, для активации аккаунта"
      redirect_to root_url
    else
      render :action => :new
    end

#    @user = User.new(params[:user])
#    @messaging_rule = MessagingRule.new(params[:messaging_rule])
#    @rules = Page.find_by_permalink("rules")
#    @user.messaging_rule=@messaging_rule
#    if params[:agreement]=="true" && @user.save
#      rating_for_choosing_dealing_center(new_user=true)
#      add_dealing_center
#      flash[:notice] = "Аккаунт создан!"
#      redirect_back_or_default account_url
#    else
#      render :action => :new
#    end
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
    if admin?
      @user = User.find(params[:id])
    else
      @user = current_user # makes our views "cleaner" and more consistent
    end
    rating_for_choosing_dealing_center
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

  def rating_for_choosing_dealing_center(new_user=false)
    unless params[:user][:dealing_center_id].blank? || ((@user.dealing_center || @user.has_rating_for_dc?) unless new_user)
      @user.add_rating(Settings.rating.bonus.for_choosing_dealing_center,User.find(:first,:conditions=>{:admin=>true}),"за выбор дилингового центра")
    end
  end

end
