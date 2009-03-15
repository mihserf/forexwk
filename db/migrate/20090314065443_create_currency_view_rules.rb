class CreateCurrencyViewRules < ActiveRecord::Migration
  def self.up
    create_table :currency_view_rules do |t|
      t.string :name
      t.string :rule
      t.text :message
      t.string :color
      t.integer :number
      
      t.timestamps
    end

    CurrencyViewRule.create(:name => "всем пользователям, включая незарегистированных", :rule => "!current_user || current_user", :number => 1)
    CurrencyViewRule.create(:name => "зарегестрированным пользователям", :rule => "current_user", :message => "Вы должны быть зарегистрированны, чтобы иметь возможность просмотреть данные по этой валютной паре", :color => "#9999cc", :number => 2)
    CurrencyViewRule.create(:name => "пользователям, с рейтингом выше 100", :rule => "current_user && current_user.stat_rating_total >= 100", :message => "Ваш рейтинг должен быть не меньше 100, чтобы иметь возможность просмотреть данные по этой валютной паре", :color => "#993399", :number => 3)
    CurrencyViewRule.create(:name => "пользователям, с рейтингом выше 300", :rule => "current_user && current_user.stat_rating_total >= 300", :message => "Ваш рейтинг должен быть не меньше 300, чтобы иметь возможность просмотреть данные по этой валютной паре", :color => "#990033", :number => 4)

  end

  def self.down
    drop_table :currency_view_rules
  end
end
