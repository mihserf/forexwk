class AddArticlesAndAdditionsToUserContest < ActiveRecord::Migration
  def self.up
    add_column :user_contests, :articles, :integer, :default => 0
    add_column :user_contests, :additions, :integer, :default => 0
  end

  def self.down
    remove_column :user_contests, :additions
    remove_column :user_contests, :articles
  end
end
