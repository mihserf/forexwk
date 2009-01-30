class AddBookToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :book_file_name, :string
    add_column  :books, :book_file_size, :string
    add_column  :books, :book_content_type, :string
    add_column  :books, :book_updated_at, :datetime
  end

  def self.down
    remove_column :books, :book
  end
end
