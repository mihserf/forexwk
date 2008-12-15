class ArticlesController < ApplicationController
  before_filter :get_catalogue
  before_filter :store_location

  def show
    @article = Article.find(params[:id])
  end

  def index
    set_ordering :date unless defined? @orders
    @articles = Article.find(:all, :include => :stat_rating, :order => @orders[:for_all])
  end

#  def per_date
#    set_ordering :date
#    index
#    render :action => "index"
#  end

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
    @catalogue = Catalogue.find(params[:catalogue_id])
  end
end
