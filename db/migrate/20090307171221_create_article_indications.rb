class CreateArticleIndications < ActiveRecord::Migration
  def self.up
    create_table :article_indications do |t|
      t.references :article
      t.references :indication

      t.timestamps
    end
  end

  def self.down
    drop_table :article_indications
  end
end
