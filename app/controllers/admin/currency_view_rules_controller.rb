class Admin::CurrencyViewRulesController < AdminController
  def new
    @currency_view_rule = CurrencyViewRule.new
  end

  def create
    @currency_view_rule = CurrencyViewRule.new(params[:currency_view_rule])
    if  @currency_view_rule.save!
      flash[:notice]="Отличие добавлено."
      redirect_to admin_currency_pairs_path
    else
      render :action => "new"
    end
  end

  def edit
    @currency_view_rule = CurrencyViewRule.find(params[:id])
  end

  def update
    @currency_view_rule = CurrencyViewRule.find(params[:id])
    if  @currency_view_rule.update_attributes(params[:currency_view_rule])
      flash[:notice]="Правило обновлено"
      redirect_to admin_currency_pairs_path
    end
  end

  def destroy
    @currency_view_rule = CurrencyViewRule.find(params[:id])
    @currency_view_rule.destroy
    respond_to do |format|
      format.html { render :inline => "Правило удалено" }
      format.xml  { head :ok }
    end
  end
end
