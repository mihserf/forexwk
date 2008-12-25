class AddNumberToContest < ActiveRecord::Migration
  def self.up
    add_column :contests, :number, :integer
  end

  def self.down
    remove_column :contests, :number
  end
end
