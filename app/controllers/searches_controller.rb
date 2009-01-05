class SearchesController < ApplicationController
  def index
      @results = []
    if params[:type]
      class_name=params[:type].classify.constantize
      
      if class_name.to_s=="Article"
        @results = ActsAsFerret::find(
          params[:q],
          [Article,Addition],
          { :page => params[:page], :per_page => 15 },
          {} # find options
        )
      else
        @results = ActsAsFerret::find(
          params[:q],
          [class_name],
          { :page => params[:page], :per_page => 15 },
          {} # find options
        )
      end
#      @results = class_name.find_with_ferret(params[:q])
#      @results.concat Addition.find_with_ferret(params[:q]) if class_name == "Article"
    else
      #@results = ActsAsFerret.find(params[:q],'shared')
      @results = ActsAsFerret::find(
        params[:q],
        [User, Article, Addition, Page, Therm],
        { :page => params[:page], :per_page => 15 },
        {} # find options
      )

#      @results.concat Article.find_with_ferret(params[:q])
#      @results.concat Addition.find_with_ferret(params[:q])
#      @results.concat Therm.find_with_ferret(params[:q])
#      @results.concat User.find_with_ferret(params[:q])
#      @results.concat Page.find_with_ferret(params[:q])
    end
      query = Query.find_or_create_by_query(params[:q])
      query.results = @results.size
      query.save
  end
end
