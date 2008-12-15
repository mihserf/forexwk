class CataloguesController < ApplicationController
  def show
    @catalogue = Catalogue.find(params[:id])
  end
  
end
