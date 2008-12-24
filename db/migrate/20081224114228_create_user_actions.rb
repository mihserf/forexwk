class CreateUserActions < ActiveRecord::Migration
  def self.up
    create_table :user_actions do |t|
      t.references :user
      t.references :action
      t.integer :rating_total
      t.decimal :rating_avg, :precision => 10, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :user_actions
  end
end
