class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :actions do |t|
      t.datetime :date_start
      t.datetime :date_end
      t.string :prize
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :actions
  end
end
