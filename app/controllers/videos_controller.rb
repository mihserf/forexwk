class VideosController < ApplicationController
  def index
    @videos=Video.paginate(:page => params[:page], :per_page => 10, :order=>"created_at DESC")
  end

  def show
    @video = Video.find(params[:id])
    @videos = Video.find(:all, :limit => 10, :order=>"created_at DESC")
  end

end
