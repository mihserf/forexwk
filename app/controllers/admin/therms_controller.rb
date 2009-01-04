class Admin::ThermsController < ApplicationController
  before_filter :admin_required



  def index
    @therms=Therm.find(:all, :order => "name DESC")
    #render(:layout=>"admin")
  end

  def new
    @therm=Therm.new
  end

  def create
    @therm=Therm.new(params[:therm])
    if  @therm.save!
      flash[:notice]="Термин создан."
      redirect_to admin_therms_path
    else
      render :action => "new"
    end
  end

  def edit
    @therm=Therm.find(params[:id])
    #render(:layout=>"admin")
  end

  def update
    @therm=Therm.find(params[:id])
    if  @therm.update_attributes(params[:therm])
      flash[:notice]="термин обновлен"
      redirect_to admin_therms_path
    end
  end

  def destroy
    @therm = Therm.find(params[:id])
    @therm.destroy
    respond_to do |format|
      format.html { redirect_to(admin_therms_url) }
      format.xml  { head :ok }
    end
  end
end
