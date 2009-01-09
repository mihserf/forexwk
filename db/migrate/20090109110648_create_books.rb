class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :name
      t.text :description
      t.text :contents
      t.string :author
      t.string :cover_file_name
      t.string :cover_file_size
      t.string :cover_content_type
      t.datetime :cover_updated_at
      t.boolean :leader
      
      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
