class AddStatAdditionsAndStatCommentsToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :stat_additions, :integer, :default => 0
    add_column :articles, :stat_comments, :integer, :default => 0
  end

  def self.down
    remove_column :articles, :stat_comments
    remove_column :articles, :stat_additions
  end
end
