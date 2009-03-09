class Admin::ArticlesController < AdminController
  def index
    params[:order]+=", created_at DESC" if params[:order]
    order = params[:order] || "created_at DESC"
    @articles = Article.paginate(:page => params[:page], :per_page => 20, :include => [:indications,:article_indications], :order => "#{order}")
    @indications = Indication.all(:order => :number)
  end
end
