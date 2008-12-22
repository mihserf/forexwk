class CreateDealingCenters < ActiveRecord::Migration
  def self.up
    create_table :dealing_centers do |t|
      t.string :name
      t.string :url
      t.text :description
      t.boolean :temp
      
      t.timestamps
    end
  end

  def self.down
    drop_table :dealing_centers
  end
end
