class CurrencyPairCurrencyViewRule < ActiveRecord::Base
  belongs_to :currency_pair
  belongs_to :currency_view_rule
end
