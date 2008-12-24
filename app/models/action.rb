class Action < ActiveRecord::Base
  has_many :user_actions, :dependent => :destroy
  has_many :users, :through => :user_actions
end
