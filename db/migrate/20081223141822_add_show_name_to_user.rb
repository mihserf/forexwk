class AddShowNameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :show_name, :boolean
  end

  def self.down
    remove_column :users, :show_name
  end
end
