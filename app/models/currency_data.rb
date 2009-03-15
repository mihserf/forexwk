class CurrencyData < ActiveRecord::Base
  belongs_to :trend_data
  belongs_to :currency_pair
  has_many :trends, :dependent => :destroy
end
