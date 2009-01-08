class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :name
      t.text :description

      t.string :video_file_name
      t.string :video_file_size
      t.string :video_content_type
      t.datetime :video_updated_at

      t.string :screenshot_file_name
      t.string :screenshot_file_size
      t.string :screenshot_content_type
      t.datetime :screenshot_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
