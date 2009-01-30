class Event < ActiveRecord::Base
  acts_as_indexed :fields => [:name, :description]
#  acts_as_ferret :fields =>{:name=>{:boost=>4},:description=>{}},:store_class_name => true
#
#  define_index do
#    indexes :name
#    indexes :description
#    has created_at, updated_at
#  end

  acts_as_seo

end
