class CreateContests < ActiveRecord::Migration
  def self.up
    create_table :contests do |t|
      t.string :name
      t.string :prize
      t.text :description
      t.datetime :date_start
      t.datetime :date_end
      t.timestamps
    end
  end

  def self.down
    drop_table :contests
  end
end
