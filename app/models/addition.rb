class Addition < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  acts_as_rateable
  
end
