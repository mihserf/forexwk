class StatRating < ActiveRecord::Base
  belongs_to :stat_rateable, :polymorphic => true
  
  
end