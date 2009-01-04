class CreateTherms < ActiveRecord::Migration
  def self.up
    create_table :therms do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :therms
  end
end
