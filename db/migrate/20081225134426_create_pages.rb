class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :permalink
      t.string :name
      t.text :content
      t.string :controller_name

      t.timestamps
    end

    Page.create(:name=>"Главная", :permalink => "home")
    Page.create(:name=>"О проекте", :permalink => "about_us")
    Page.create(:name=>"Правила", :permalink => "rules")
    Page.create(:name=>"Обратная связь", :permalink => "contacts")
  end

  def self.down
    drop_table :pages
  end
end
