class AddRulesToContest < ActiveRecord::Migration
  def self.up
    add_column :contests, :rules, :text
  end

  def self.down
    remove_column :contests, :rules
  end
end
