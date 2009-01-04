class Therm < ActiveRecord::Base
  acts_as_ferret :fields =>[:name,:description]
end
