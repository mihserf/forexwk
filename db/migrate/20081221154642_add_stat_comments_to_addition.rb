class AddStatCommentsToAddition < ActiveRecord::Migration
  def self.up
    add_column :additions, :stat_comments, :integer, :default => 0
  end

  def self.down
    remove_column :additions, :stat_comments
  end
end
