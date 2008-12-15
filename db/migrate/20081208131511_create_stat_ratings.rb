class CreateStatRatings < ActiveRecord::Migration
  def self.up
    create_table :stat_ratings do |t|
      t.decimal :rating_total
      t.decimal :rating_avg, :precision => 10, :scale => 2
      t.string :stat_rateable_type, :limit => 15, :default => "", :null => false
      t.integer :stat_rateable_id, :default => 0, :null => false
      t.timestamps
    end

    add_index "stat_ratings",["stat_rateable_id"], :name => "fk_stat_ratings_stat_rateable_type"
  end

  def self.down
    drop_table :stat_ratings
  end
end
