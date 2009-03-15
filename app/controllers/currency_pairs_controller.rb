class CurrencyPairsController < ApplicationController
  def archive
    @message = nil
    @currency_pair = CurrencyPair.find_by_name(params[:id])
    currency_pair_id = CurrencyPair.find_by_name(params[:id]).id
    currency_pairs = CurrencyPair.all_for_user(current_user).map(&:id)
    if currency_pairs.include?(currency_pair_id)
      @currency_datas = @currency_pair.currency_datas.all(:include => :trends, :order => "created_at DESC" )
    else
      rule = CurrencyPairCurrencyViewRule.all(:joins => :currency_view_rule, :conditions => {:currency_pair_id => currency_pair_id}, :order => "currency_view_rules.number").map{|i| i.currency_view_rule}.first
      @message = rule.nil? ? "Вам пока недоступны данные по этой валютной паре" : rule.message
    end

    
    
  end
end
