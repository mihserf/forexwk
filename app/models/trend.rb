class Trend < ActiveRecord::Base
  belongs_to :currency_data

  BEGIN_S = 1
  MIDDLE_S = 2
  END_S    = 3

  STAGES = {
    BEGIN_S => "начало",
    MIDDLE_S => "середина",
    END_S => "конец"
  }.freeze

  BULL_C = 1
  BEAR_C = 2

  CHARACTERS = {
    BULL_C => "бычий",
    BEAR_C => "медвежий"
  }

  DAY_T = 1
  WEEK_T = 2
  MONTH_T = 3

  TYPES = {
    DAY_T => "краткосрочный",
    WEEK_T => "среднесрочный",
    MONTH_T => "долгосрочный"
  }

end
