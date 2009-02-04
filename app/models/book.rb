class Book < ActiveRecord::Base
  
  has_attached_file :cover,
                    :styles => { :thumb => "81x106>",
                                 :normal  => "111x136>" },
                    :url => "/attachments/:class/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/attachments/:class/:id/:style_:basename.:extension"
  has_attached_file :book#,
                    #:path => ":rails_root/public/attachments/:class/:id/:style_:basename.:extension"

  acts_as_indexed :fields => [:name, :author, :contents, :description]
#  acts_as_ferret :fields =>{:name=>{:boost=>4},:author=>{:boost=>4},:contents=>{:boost=>3},:description=>{}},:store_class_name => true
#  define_index do
#    indexes :name
#    indexes :description
#    indexes :contents
#    indexes :author
#    has created_at, updated_at
#  end

  acts_as_seo

end
