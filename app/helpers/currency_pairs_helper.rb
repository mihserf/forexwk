module CurrencyPairsHelper
  def currency_pairs_filter
    pairs = CurrencyPair.all_for_user(current_user)
    render  :partial => '/currency_pairs/currency_pairs_filter', :locals => {:pairs => pairs}
  end
end
