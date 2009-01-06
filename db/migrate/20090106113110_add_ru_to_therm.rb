class AddRuToTherm < ActiveRecord::Migration
  def self.up
    add_column :therms, :ru, :boolean
  end

  def self.down
    remove_column :therms, :ru
  end
end
