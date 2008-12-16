class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :name
      t.text :short
      t.text :content
      t.boolean :temp
      t.references :catalogue
      t.references :user

      
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
