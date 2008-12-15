module ArticlesHelper
  def top_articles_of(catalogue, order = "stat_ratings.rating_avg DESC")
    articles = catalogue.articles.find(:all, :limit => 10, :include => :stat_rating, :order => order)
    render :partial => "articles/top_articles_of", :locals => { :items => articles }
  end
end
