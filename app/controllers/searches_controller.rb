class SearchesController < ApplicationController
  def index
    @results = []
    if params[:type]
      class_name=params[:type].classify.constantize

      #@results = class_name.search params[:q], :page => params[:page], :per_page => 15
       @results = class_name.find_with_index params[:q]
#      if class_name.to_s=="Article"
#        @results = ActsAsFerret::find(
#          params[:q],
#          [Article,Addition],
#          { :page => params[:page], :per_page => 15 },
#          {} # find options
#        )
#      else
#        @results = ActsAsFerret::find(
#          params[:q],
#          [class_name],
#          { :page => params[:page], :per_page => 15 },
#          {} # find options
#        )
#      end

    else
      #@results = ThinkingSphinx::Search.search(params[:q], :page => params[:page], :per_page => 15).reject(&:nil?)
      classes = [User, Article, Addition, Page, Therm, Book, Video, Event, DealingCenter]
       classes.each do |i|
         result = i.find_with_index params[:q]
         @results+= result unless result.empty?
       end
       @results=@results.paginate_result(params[:page] || 1, 15)
#      @results = ActsAsFerret::find(
#        params[:q],
#        [User, Article, Addition, Page, Therm, Book, Video, Event, DealingCenter],
#        { :page => params[:page], :per_page => 15 },
#        {} # find options
#      )

    end
      query = Query.find_or_create_by_query(params[:q])
      query.results = @results.count
      query.queries+=1
      query.save
  end
end
