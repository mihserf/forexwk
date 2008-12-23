class AddStatusStringToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :status_string, :string
  end

  def self.down
    remove_column :users, :status_string
  end
end
