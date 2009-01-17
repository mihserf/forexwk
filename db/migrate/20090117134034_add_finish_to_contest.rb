class AddFinishToContest < ActiveRecord::Migration
  def self.up
    add_column :contests, :finished, :boolean
  end

  def self.down
    remove_column :contests, :finished
  end
end
