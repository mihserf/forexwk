class Therm < ActiveRecord::Base
  before_save :set_ru
  before_save :set_permalink

  acts_as_indexed :fields => [:name, :description]
#  acts_as_ferret :fields =>{:name=>{:boost=>4},:description=>{}},:store_class_name => true
#
#  define_index do
#    indexes :name
#    indexes :description
#    has created_at, updated_at
#  end

  def set_ru
    bytes=[]
    self.name.first.each_byte{|i| bytes<<i}
    if (bytes.first>=128 && bytes.first<=209)
      self.ru=true 
    else
      self.ru=nil
    end
  end

  def set_permalink
    permalink = name.dirify
  end
end
