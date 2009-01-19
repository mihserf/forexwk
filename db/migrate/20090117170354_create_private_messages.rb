class CreatePrivateMessages < ActiveRecord::Migration
  def self.up
    create_table :private_messages do |t|
      t.integer :sender_id, :integer
      t.integer :recipient_id, :integer
      t.string :title, :string
      t.text :body, :text
      t.text :body_html, :text
      t.boolean :sender_deleted, :boolean, :default => false
      t.boolean :recipient_deleted, :boolean, :default => false
      t.timestamps
    end

    add_index :private_messages, :sender_id
    add_index :private_messages, :recipient_id
  end

  def self.down
    drop_table :private_messages
    remove_index :private_messages, :sender_id
    remove_index :private_messages, :recipient_id
  end
end
