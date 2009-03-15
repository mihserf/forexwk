class CreateCurrencyPairCurrencyViewRules < ActiveRecord::Migration
  def self.up
    create_table :currency_pair_currency_view_rules do |t|
      t.references :currency_pair
      t.references :currency_view_rule

      t.timestamps
    end
  end

  def self.down
    drop_table :currency_pair_currency_view_rules
  end
end
