class Admin::EventsController < ApplicationController

  def index
    @events=Event.find(:all, :order=>"created_at DESC")
  end

  def new
    @event=Event.new
  end

  def create
    @event=Event.new(params[:event])
    if  @event.save!
      flash[:notice]="Событие добавлено."
      redirect_to admin_events_path
    else
      render :action => "new"
    end
  end

  def edit
    @event=Event.find(params[:id])
  end

  def update
    @event=Event.find(params[:id])
    if  @event.update_attributes(params[:event])
      flash[:notice]="Событие обновлено"
      redirect_to admin_events_path
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to(admin_events_url) }
      format.xml  { head :ok }
    end
  end
end
