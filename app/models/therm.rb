class Therm < ActiveRecord::Base
  acts_as_ferret :fields =>{:name=>{:boost=>4},:description=>{}},:store_class_name => true
end
