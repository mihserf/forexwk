class DealingCentersController < ApplicationController
  def index
    @dealing_centers = DealingCenter.paginate(:page => params[:page], :per_page => 20, :conditions=>["temp=?",false], :order=>"name")
  end
end
