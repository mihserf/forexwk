class AddQueriesToQuery < ActiveRecord::Migration
  def self.up
    add_column :queries, :queries, :integer, :default => 0
  end

  def self.down
    remove_column :queries, :queries
  end
end
