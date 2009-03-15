class CurrencyViewRule < ActiveRecord::Base
  has_many :currency_pair_currency_view_rules, :dependent => :destroy
  has_many :currency_pairs, :through => :currency_pair_currency_view_rules
end
