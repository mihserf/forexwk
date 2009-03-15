class Admin::CurrencyPairCurrencyViewRulesController < AdminController
  def create
    CurrencyPairCurrencyViewRule.find_or_create_by_currency_view_rule_id_and_currency_pair_id(params[:currency_view_rule_id], params[:currency_pair_id]) unless params[:currency_view_rule_id].blank? || params[:currency_pair_id].blank?

    respond_to do |format|
      format.html{ redirect_to admin_currency_pairs_path }
      format.js{ render :inline => "created" }
    end
  end

  def destroy
    CurrencyPairCurrencyViewRule.delete_all({:currency_view_rule_id => params[:currency_view_rule_id], :currency_pair_id => params[:currency_pair_id]}) unless params[:currency_view_rule_id].blank? || params[:currency_pair_id].blank?

    respond_to do |format|
      format.html{ redirect_to admin_currency_pairs_path }
      format.js{ render :inline => "destroied"  }
    end
  end
end
