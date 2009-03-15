class TrendDatasController < ApplicationController

  def index
  end

  def show
    @message = nil
    @trend_data = TrendData.find(params[:id])
    currency_pair_id = CurrencyPair.find_by_name(params[:currency_pair_id]).id
    currency_pairs = CurrencyPair.all_for_user(current_user).map(&:id)
    if params[:currency_pair_id] && currency_pairs.include?(currency_pair_id)
      currency_pair = currency_pair_id
    else
      currency_pair = nil
    end
    @trends = Trend.all(:include => {:currency_data => :currency_pair}, :conditions => ["currency_datas.trend_data_id=? AND currency_pairs.id IN (?)",@trend_data.id, currency_pair])

    if @trends.empty?
      #rule = CurrencyViewRule.first(:include => :currency_pair_currency_view_rules, :conditions => ["currency_pair_currency_view_rules.currency_pair_id=?",currency_pair], :order => :number)
      rule = CurrencyPairCurrencyViewRule.all(:joins => :currency_view_rule, :conditions => {:currency_pair_id => currency_pair_id}, :order => "currency_view_rules.number").map{|i| i.currency_view_rule}.first
      @message = rule.nil? ? "Вам пока недоступны данные по этой валютной паре" : rule.message
    end
    
    render :partial => "show", :locals => {:trend_data => @trend_data , :trends => @trends, :message => @message }
  end


end
