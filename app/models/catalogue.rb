class Catalogue < ActiveRecord::Base
  has_many :articles
  acts_as_nested_set
  acts_as_seo

end
