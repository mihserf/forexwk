class DealingCentersController < ApplicationController
  def index
    @dealing_centers = DealingCenter.paginate(:page => params[:page], :per_page => 10, :conditions=>["temp=?",false], :order=>"created_at DESC")
  end
end
