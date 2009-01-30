class Metatag < ActiveRecord::Base
  belongs_to :metatagable, :polymorphic => true
end