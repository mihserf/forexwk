class AddIndexArticleIdToAddition < ActiveRecord::Migration
  def self.up
    add_index :additions, :article_id
  end

  def self.down
    remove_index :additions, :article_id
  end
end
