class Admin::VideosController < ApplicationController
  before_filter :admin_required



  def index
    @videos=Video.find(:all, :order=>"created_at DESC")
  end

  def new
    @video=Video.new
  end

  def create
    @video=Video.new(params[:video])
    if  @video.save!
      flash[:notice]="Видео-урок создан."
      redirect_to admin_videos_path
    else
      render :action => "new"
    end
  end

  def edit
    @video=Video.find(params[:id])
  end

  def update
    @video=Video.find(params[:id])
    if  @video.update_attributes(params[:video])
      flash[:notice]="Видео-урок обновлен"
      redirect_to admin_videos_path
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    respond_to do |format|
      format.html { redirect_to(admin_videos_url) }
      format.xml  { head :ok }
    end
  end
end
