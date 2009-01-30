class Page < ActiveRecord::Base
  acts_as_indexed :fields => [:content]
#  acts_as_ferret :fields => {:content=>{}},:store_class_name => true
#
#  define_index do
#    indexes :content
#  end

  acts_as_seo
  
end
