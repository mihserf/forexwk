class Contest < ActiveRecord::Base
  has_many :user_contests, :dependent => :destroy
  has_many :users, :through => :user_contests
end
