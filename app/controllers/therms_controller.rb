class ThermsController < ApplicationController
  def index
    @therms=Therm.find(:all, :order => "name")
    #render(:layout=>"admin")
  end

  def show
    @therm = Therm.find(params[:id])
  end
end
