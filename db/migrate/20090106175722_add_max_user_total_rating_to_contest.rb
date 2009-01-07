class AddMaxUserTotalRatingToContest < ActiveRecord::Migration
  def self.up
    add_column :contests, :max_user_total_rating, :integer
  end

  def self.down
    remove_column :contests, :max_user_total_rating
  end
end
