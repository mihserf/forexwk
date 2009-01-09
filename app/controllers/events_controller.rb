class EventsController < ApplicationController
  def index
    @events = Event.paginate(:page => params[:page], :per_page => 10, :order=>"created_at DESC")
  end

  def show
    @event = Event.find(params[:id])
  end
end
