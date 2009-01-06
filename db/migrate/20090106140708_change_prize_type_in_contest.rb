class ChangePrizeTypeInContest < ActiveRecord::Migration
  def self.up
    change_column :contests, :prize, :integer
  end

  def self.down
  end
end
