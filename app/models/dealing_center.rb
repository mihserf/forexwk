class DealingCenter < ActiveRecord::Base
  has_many :users
  
  acts_as_ferret :fields =>{:name=>{:boost=>4},:description=>{},:url=>{}},:store_class_name => true, :remote => true
end
