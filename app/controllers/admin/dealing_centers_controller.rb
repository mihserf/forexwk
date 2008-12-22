class Admin::DealingCentersController < ApplicationController

 before_filter :admin_required


  def index
    @dealing_centers=DealingCenter.find(:all, :order => :name)
  end

  def new
    @dealing_center=DealingCenter.new
  end

  def create
    @dealing_center=DealingCenter.new(params[:dealing_center])

    if  @dealing_center.save!
      flash[:notice]="Диллинговый центр создан."
      redirect_to admin_dealing_centers_path
    else
      render :action => "new"
    end
  end

  def edit
    @dealing_center=DealingCenter.find(params[:id])
  end

  def update
    @dealing_center=DealingCenter.find(params[:id])

    if  @dealing_center.update_attributes(params[:dealing_center])
      flash[:notice]="Диллинговый центр обновлен"
      redirect_to admin_dealing_centers_path
    end
  end

  def destroy
    @dealing_center = DealingCenter.find(params[:id])
    @dealing_center.destroy
    respond_to do |format|
      format.html { redirect_to(admin_dealing_centers_url) }
      format.xml  { head :ok }
    end
  end

end
