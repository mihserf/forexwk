class AddCachedTagListToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :cached_tag_list, :string
  end

  def self.down
    remove_column :articles, :cached_tag_list
  end
end
