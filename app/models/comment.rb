class Comment < ActiveRecord::Base
  belongs_to :addition
  belongs_to :user
end
