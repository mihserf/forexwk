class ArticlesController < ApplicationController
  before_filter :get_catalogue
  before_filter :get_user, :only => [:index, :per_rating]
  before_filter :store_location, :except => [:new,:create,:edit,:update]
  before_filter :require_user, :only => [:new,:create,:edit,:update]
  before_filter :moderator_required, :only => :destroy

  def show
    @article = Article.find(params[:id], :include => :additions)
    @addition = Addition.new(:user => current_user, :article => @article)
  end

  def index
    set_ordering :date unless defined? @orders
    if @catalogue 
      @articles = @catalogue.articles.find(:all, :include => :stat_rating, :order => @orders[:for_all])
    elsif @user
      @articles = @user.articles.find(:all, :include => :stat_rating, :order => @orders[:for_all])
    else
      @articles = Article.find(:all, :include => :stat_rating, :order => @orders[:for_all])
    end
  end

  def new
    @article = Article.new(:catalogue_id => @catalogue.id, :temp => true)
  end

  def create
    @article = Article.new(params[:article])
    @article.catalogue_id = @catalogue.id
    @article.user_id = current_user.id
    @article.temp = true
    @article.build_stat_rating(:rating_avg => 0,:rating_total => 0)
    if @article.save
      flash[:notice]="Спасибо. Статья создана. Появится в ближайшее время, после проверки"
      redirect_back_or_default catalogue_articles_path(@catalogue)
    else
      render :action => "new"
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if  @article.update_attributes(params[:article])
      if params[:rate]=="true" && current_user.moderator? && !@article.temp then @article.user.add_rating(Settings.rating.bonus.for_article,User.find(:first,:conditions => {:admin=>true},:select=>"admin,id").id,"за статью") end
      flash[:notice]="Статья обновлена."
      redirect_back_or_default catalogue_articles_path(@catalogue)
    end
  end

#  def per_date
#    set_ordering :date
#    index
#    render :action => "index"
#  end

  def destroy
    Article.destroy(params[:id])
    render :inline => "Статья удалена"
  end

  def per_rating
    set_ordering :rating
    index
    render :action => "index"
  end

  def set_ordering(order)
    @orders = {:for_all => nil,:for_top => nil}
    date = "created_at DESC"
    rating = "stat_ratings.rating_avg DESC"
    if order==:rating then @orders[:for_all] = rating; @orders[:for_top] = date
    else
      @orders[:for_all] = date; @orders[:for_top] = rating
    end
  end

  def get_catalogue
    @catalogue = params[:catalogue_id].nil? ? nil : Catalogue.find(params[:catalogue_id])
  end
  def get_user
    @user = params[:user_id].nil? ? nil : User.find(params[:user_id])
  end
end
