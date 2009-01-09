class Book < ActiveRecord::Base
  acts_as_ferret :fields =>{:name=>{:boost=>4},:author=>{:boost=>4},:contents=>{:boost=>3},:description=>{}},:store_class_name => true
  has_attached_file :cover,
                    :styles => { :thumb => "81x106>",
                                 :normal  => "111x136>" },
                    :url => "/attachments/:class/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/attachments/:class/:id/:style_:basename.:extension"

end
