class CreateIndications < ActiveRecord::Migration
  def self.up
    create_table :indications do |t|
      t.string :name
      t.integer :max_articles
      t.integer :number
      t.integer  :filter_id # фильтры прописаны в модели Article
      t.timestamps
    end
    Indication.create(:name => "Рекомендуемые статьи", :max_articles => 5, :number => 1)
    Indication.create(:name => "Последние статьи на сайте", :max_articles => 5, :number => 2, :filter_id => Article::BY_DATE)
    Indication.create(:name => "Рейтинговые статьи", :max_articles => 5, :number => 3, :filter_id => Article::BY_RATING)
    Indication.create(:name => "Статьи для новичков", :max_articles => 5, :number => 4)
  end

  def self.down
    drop_table :indications
  end
end
