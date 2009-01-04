class Page < ActiveRecord::Base
  acts_as_ferret :fields => [:content]
end
