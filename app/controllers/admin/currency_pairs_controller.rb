class Admin::CurrencyPairsController < AdminController
  def index
    @currency_pairs = CurrencyPair.all(:include => [:currency_view_rules,:currency_pair_currency_view_rules], :order => :name)
    @currency_view_rules = CurrencyViewRule.all
  end
  
  def new
    @currency_pair = CurrencyPair.new
  end

  def create
    @currency_pair = CurrencyPair.new(params[:currency_pair])
    if  @currency_pair.save!
      flash[:notice]="Отличие добавлено."
      redirect_to admin_currency_pairs_path
    else
      render :action => "new"
    end
  end

  def edit
    @currency_pair = CurrencyPair.find(params[:id])
  end

  def update
    @currency_pair = CurrencyPair.find(params[:id])
    if  @currency_pair.update_attributes(params[:currency_pair])
      flash[:notice]="Пара обновлена"
      redirect_to admin_currency_pairs_path
    end
  end

  def destroy
    @currency_pair = CurrencyPair.find(params[:id])
    @currency_pair.destroy
    respond_to do |format|
      format.html { render :inline => "Пара удалена" }
      format.xml  { head :ok }
    end
  end
end
