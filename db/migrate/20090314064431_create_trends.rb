class CreateTrends < ActiveRecord::Migration
  def self.up
    create_table :trends do |t|
      t.integer :trend_type
      t.integer :character
      t.integer :stage
      t.float :prob_cont
      t.references :currency_data

      t.timestamps
    end
  end

  def self.down
    drop_table :trends
  end
end
