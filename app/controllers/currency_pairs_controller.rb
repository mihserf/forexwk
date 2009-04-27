class CurrencyPairsController < ApplicationController
  def show
    @message = nil
    @currency_pair = CurrencyPair.all_with_rules_for_user(current_user, :conditions => ["currency_pairs.name=:name",{:name=>params[:id]}]).first
    
    unless @currency_pair.denied
      @currency_datas = @currency_pair.currency_datas.paginate(:page => params[:page], :per_page => 12, :include => [:trends,:trend_data], :order => "trend_datas.created_at DESC" )
    else
      @currency_pair.message = @currency_pair.message.nil? ? "Вам пока недоступны данные по этой валютной паре" : @currency_pair.message
    end

  end

  def index
    conditions = ["",{}]
    if params[:currency_pairs].blank?
      currency_conditions = nil
    else
      currency_conditions = ["(currency_pairs.name IN (:names))",{:names => params[:currency_pairs]}]
      conditions[0]+=currency_conditions[0]
      conditions[1].merge! currency_conditions[1]
    end
    
    if params[:date_begin].blank? && params[:date_end].blank?
      date_conditions = nil
    else
      date_conditions = [" (trend_datas.created_at BETWEEN :date_begin AND :date_end) ",{:date_begin => params[:date_begin].to_date, :date_end => params[:date_end].to_date}]
      conditions[0]+=(conditions[0].blank? ? "" : " AND ")+date_conditions[0]
      conditions[1].merge! date_conditions[1]
    end



    @currency_pairs = CurrencyPair.all_with_rules_for_user(current_user, :include => [{:currency_datas => :trends}], :conditions => currency_conditions).sort_by {|i| [i.denied_for_sort, i.view_rule_number, i.name]}
    #@currency_datas = CurrencyData.paginate(:page => params[:page], :per_page => 12, :include => [:currency_pair, :trend_data, :trends], :conditions => conditions, :order => "trend_datas.created_at DESC, currency_pairs.name" )
    @currency_datas = CurrencyData.find(:all, :include => [:currency_pair, :trend_data, :trends], :conditions => conditions )#.sort_by {|a| a.currency_pair=@currency_pairs.find{|i| i.id == a.currency_pair.id}; [-a.trend_data.created_at.to_i, a.currency_pair.denied_for_sort, a.currency_pair.name]}
    @currency_datas = @currency_datas.paginate_result(params[:page] || 1, 12)
  end
end