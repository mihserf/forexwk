class Therm < ActiveRecord::Base
  acts_as_ferret :fields =>{:name=>{:boost=>4},:description=>{}},:store_class_name => true
  before_save :set_ru

  def set_ru
    bytes=[]
    self.name.first.each_byte{|i| bytes<<i}
    self.ru=true if (bytes.first>=128 && bytes.first<=209)
  end
end
