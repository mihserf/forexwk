class CreateMessagingRules < ActiveRecord::Migration
  def self.up
    create_table :messaging_rules do |t|
      t.boolean :rating_changed, :addition_added, :comment_added, :new_contest
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :messaging_rules
  end
end
