class Admin::IndicationsController < AdminController

  def new
    @indication = Indication.new
  end

  def create
    @indication = Indication.new(params[:indication])
    if  @indication.save!
      flash[:notice]="Отличие добавлено."
      redirect_to admin_articles_path
    else
      render :action => "new"
    end
  end

  def edit
    @indication = Indication.find(params[:id])
  end

  def update
    @indication = Indication.find(params[:id])
    if  @indication.update_attributes(params[:indication])
      flash[:notice]="Отличие обновлено"
      redirect_to admin_articles_path
    end
  end

  def destroy
    @indication = Indication.find(params[:id])
    @indication.destroy
    respond_to do |format|
      format.html { render :inline => "Отличие удалено" }
      format.xml  { head :ok }
    end
  end

end
