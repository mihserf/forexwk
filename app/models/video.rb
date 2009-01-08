class Video < ActiveRecord::Base
  has_attached_file :video,
                    :url => "/attachments/:class/video/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/attachments/:class/video/:id/:style_:basename.:extension"
  has_attached_file :screenshot,
                    :styles => { :thumb => ["79x55#", :jpg],
                                 :medium => ["179x155#", :jpg],
                                 :normal  => "640x385>" },
                    :url => "/attachments/:class/screenshot/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/attachments/:class/screenshot/:id/:style_:basename.:extension"

  #validates_attachment_presence :video, :content_type => ['video/x-flv', 'flv-application/octet-stream', 'application/octet-stream']

end
