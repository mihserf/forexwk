class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.text :description
      t.text :short_description

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
