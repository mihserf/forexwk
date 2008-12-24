class CreateUserContests < ActiveRecord::Migration
  def self.up
    create_table :user_contests do |t|
      t.references :user
      t.references :contest
      t.integer :rating_total
      t.decimal :rating_avg, :precision => 10, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :user_contests
  end
end
