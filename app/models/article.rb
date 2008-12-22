class Article < ActiveRecord::Base
  belongs_to :catalogue
  belongs_to :user

  has_many :additions, :dependent => :destroy

  acts_as_rateable
  acts_as_taggable

  #acts_as_list :scope => :catalogue

  def has_additions?
    !additions.empty?
  end
end
