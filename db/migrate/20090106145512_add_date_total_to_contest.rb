class AddDateTotalToContest < ActiveRecord::Migration
  def self.up
    add_column :contests, :date_total, :datetime
  end

  def self.down
    remove_column :contests, :date_total
  end
end
