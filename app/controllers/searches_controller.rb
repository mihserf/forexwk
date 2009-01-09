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

    else
      #@results = ActsAsFerret.find(params[:q],'shared')
      @results = ActsAsFerret::find(
        params[:q],
        [User, Article, Addition, Page, Therm, Book, Video, Event, DealingCenter],
        { :page => params[:page], :per_page => 15 },
        {} # find options
      )

    end
      query = Query.find_or_create_by_query(params[:q])
      query.results = @results.total_hits
      query.queries+=1
      query.save
  end
end
