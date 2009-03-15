class Admin::TrendDatasController < AdminController
  def index
    @trend_datas=TrendData.find(:all, :order=>"created_at DESC")
  end

  def new
    @trend_data=TrendData.new
  end

  def create
    @trend_data=TrendData.new(params[:trend_data])
    if  @trend_data.save!
      flash[:notice]="Тренд добавлен."
      redirect_to admin_trend_datas_path
    else
      render :action => "new"
    end
  end

  def edit
    @trend_data=TrendData.find(params[:id])
  end

  def update
    @trend_data=TrendData.find(params[:id])
    if  @trend_data.update_attributes(params[:trend_data])
      flash[:notice]="Тренд обновлен"
      redirect_to admin_trend_datas_path
    end
  end

  def destroy
    @trend_data = TrendData.find(params[:id])
    @trend_data.destroy
    respond_to do |format|
      format.html { redirect_to(admin_trend_datas_url) }
      format.xml  { head :ok }
    end
  end

  def download_data
    @trend_data = TrendData.find(params[:id])
    send_file @trend_data.excel_data.path, :type=>"application/zip"
  end

end
