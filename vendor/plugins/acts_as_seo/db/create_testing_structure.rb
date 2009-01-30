class CreateTestingStructure < ActiveRecord::Migration
  def self.up
    create_table :metatags, :force => true do |t|
      t.string :title, :keywords, :metatagable_type
      t.text :description
      t.integer :metatagable_id
      t.timestamps
    end
    
    create_table :pages, :force => true do |t|
      t.string :title
      t.text :body
      t.timestamps
    end
    
    create_table :test_pages, :force => true do |t|
    end
  end

  def self.down
    drop_table :test_pages
    drop_table :pages
    drop_table :metatags
  end
end