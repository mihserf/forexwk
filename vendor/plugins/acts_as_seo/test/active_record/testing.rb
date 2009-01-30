require 'rubygems'
require 'active_record'
require File.dirname(__FILE__) + "/../../lib/active_record/acts/seo"
require File.dirname(__FILE__) + "/../../lib/metatag.rb"
ActiveRecord::Base.send :include, ActiveRecord::Acts::SEO

# This approach is based on Chris Roos post at http://blog.seagul.co.uk/articles/2006-02-08-in-memory-sqlite-database-for-rails-testing
# In this way I cannot create special classes to work without a table. I create the database and tables into the memory.

# Here I stablish the connection using :database=>":memory:"
ActiveRecord::Base.establish_connection(:adapter=>"sqlite3", :database => ":memory:")
# And I require the migration file which will create the tables
require File.dirname(__FILE__) + "/../../db/create_testing_structure"
# Then I put it up
CreateTestingStructure.migrate(:up)

class Page < ActiveRecord::Base; acts_as_seo end
class TestPage < ActiveRecord::Base; end