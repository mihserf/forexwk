class SearchesController < ApplicationController
  def index
      @results = []
    if params[:type]
      class_name=params[:type].classify.constantize
      @results = class_name.find_with_ferret(params[:q])
      #@results.concat Addition.find_with_ferret(params[:q]) if class_name == "Article"
    else
      @results.concat Article.find_with_ferret(params[:q])
      #@results.concat Addition.find_with_ferret(params[:q])
      @results.concat Therm.find_with_ferret(params[:q])
      @results.concat User.find_with_ferret(params[:q])
      #@results.concat Page.find_with_ferret(params[:q])
    end
      query = Query.find_or_create_by_query(params[:q])
      query.results = @results.size
      query.save
  end
end
