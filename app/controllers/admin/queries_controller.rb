class Admin::QueriesController < ApplicationController
  before_filter :admin_required

  def index
    @queries = Query.find(:all, :order => "results")
  end
end
