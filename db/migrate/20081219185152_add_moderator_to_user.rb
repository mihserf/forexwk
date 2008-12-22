class AddModeratorToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :moderator, :boolean
  end

  def self.down
    remove_column :users, :moderator
  end
end
