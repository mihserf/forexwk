class CreateCatalogues < ActiveRecord::Migration
  def self.up
    create_table :catalogues do |t|
      t.string :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      
      t.timestamps
    end
  end

  def self.down
    drop_table :catalogues
  end
end
