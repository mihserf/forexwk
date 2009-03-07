class AddCommerceToDealingCenter < ActiveRecord::Migration
  def self.up
    add_column :dealing_centers, :commerce, :boolean
    add_column :dealing_centers, :full_description, :text
  end

  def self.down
    remove_column :dealing_centers, :full_description
    remove_column :dealing_centers, :commerce
  end
end
