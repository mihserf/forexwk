class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.decimal :rating, :default => 0
      t.string :rateable_type, :limit => 15, :default => "", :null => false
      t.integer :rateable_id, :default => 0, :null => false
      t.integer :user_id, :default => 0, :null => false
      t.string :reason
      t.timestamps

    end

    add_index "ratings",["user_id"], :name => "fk_ratings_user"
  end

  def self.down
    drop_table :ratings
  end
end
