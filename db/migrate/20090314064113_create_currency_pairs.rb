class CreateCurrencyPairs < ActiveRecord::Migration
  def self.up
    create_table :currency_pairs do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :currency_pairs
  end
end
