class Book < ActiveRecord::Base
  has_attached_file :cover,
                    :styles => { :thumb => "81x106>",
                                 :normal  => "111x136>" },
                    :url => "/attachments/:class/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/attachments/:class/:id/:style_:basename.:extension"

end
