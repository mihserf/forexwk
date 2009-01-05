class Admin::QueriesController < ApplicationController
  before_filter :admin_required

  def index
    @queries = Query.find(:all, :limit =>200, :order => "results")
  end

  def destroy
    @query = Query.find(params[:id])
    @query.destroy
    respond_to do |format|
      format.html { redirect_to(admin_queries_url) }
      format.xml  { head :ok }
      format.js { render :inline => "Запрос удалён"}
    end
  end

end
