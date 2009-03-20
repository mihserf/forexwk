class TrendDatasController < ApplicationController

  def index
  end

  def show
    @message = nil
    @trend_data = TrendData.find(params[:id])
    currency_pair = CurrencyPair.all_with_rules_for_user(current_user, :conditions => ["currency_pairs.name=:name",{:name=>params[:currency_pair_id]}]).first

    unless currency_pair.denied
      @trends = currency_pair.currency_datas.find(:first, :conditions => ["trend_data_id=?",@trend_data.id]).trends
      @currency_data = currency_pair.currency_datas.find(:first, :conditions => ["trend_data_id=?",@trend_data.id])
    else
      currency_pair.message = currency_pair.message.nil? ? "Вам пока недоступны данные по этой валютной паре" : currency_pair.message
    end
    render :partial => "show", :locals => {:currency_pair => currency_pair, :trend_data => @trend_data , :currency_data => @currency_data, :trends => @trends, :show_date => true}
  end

end
