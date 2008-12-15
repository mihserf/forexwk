class CreateAdditions < ActiveRecord::Migration
  def self.up
    create_table :additions do |t|
      t.string :name
      t.text :content
      t.references :article
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :additions
  end
end
