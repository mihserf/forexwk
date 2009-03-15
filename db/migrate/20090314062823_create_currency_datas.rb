class CreateCurrencyDatas < ActiveRecord::Migration
  def self.up
    create_table :currency_datas do |t|
      t.references :trend_data
      t.references :currency_pair
      t.float :currency_price

      t.timestamps
    end
  end

  def self.down
    drop_table :currency_datas
  end
end
