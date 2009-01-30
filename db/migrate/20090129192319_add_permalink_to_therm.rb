class AddPermalinkToTherm < ActiveRecord::Migration
  def self.up
    add_column :therms, :permalink, :string
  end

  def self.down
    remove_column :therms, :permalink
  end
end
