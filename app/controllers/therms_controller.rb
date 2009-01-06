class ThermsController < ApplicationController
  def index
    @therms=Therm.find(:all, :order => "ru DESC,name")
    #@therms=Therm.paginate(:page => params[:page], :per_page => 10, :order => "ru DESC,name")
    #render(:layout=>"admin")
  end

  def show
    @therm = Therm.find(params[:id])
  end
end
