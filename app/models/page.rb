class Page < ActiveRecord::Base
  acts_as_ferret :fields => {:content=>{}},:store_class_name => true
end
