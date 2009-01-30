root = "#{File.dirname(__FILE__)}/../../.."
migration = File.dirname(__FILE__) + "/db/create_seo_structure.rb"

system("cp #{migration} #{root}/db/migrate/#{Time.now.strftime('%Y%m%d%H%M%S')}_create_seo_structure.rb")

puts <<-EOF


  Now, run the rake db:migrate task to create the metatags table.
  Then configure your model like it:
  
  class Page < ActiveRecord::Base
    acts_as_seo
  end
  
  And enjoy! ;)
  
  
EOF