class DealingCenter < ActiveRecord::Base
  has_many :users

  acts_as_indexed :fields => [:name, :description, :url]
  #acts_as_ferret :fields =>{:name=>{:boost=>4},:description=>{},:url=>{}},:store_class_name => true, :remote => true

#  define_index do
#    indexes :name
#    indexes :description
#    indexes :url
#    has created_at, updated_at
#  end

end
