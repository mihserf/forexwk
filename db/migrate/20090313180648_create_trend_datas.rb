class CreateTrendDatas < ActiveRecord::Migration
  def self.up
    create_table :trend_datas do |t|
      t.string :name
      t.string :excel_data_file_name
      t.string :excel_data_file_size
      t.string :excel_data_content_type
      t.datetime :excel_data_updated_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :trend_datas
  end
end
