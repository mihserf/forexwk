class AddAddedByUserToDealingCenter < ActiveRecord::Migration
  def self.up
    add_column :dealing_centers, :added_by_user, :integer
  end

  def self.down
    remove_column :dealing_centers, :added_by_user
  end
end
