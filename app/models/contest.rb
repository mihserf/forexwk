class Contest < ActiveRecord::Base
  has_many :user_contests, :dependent => :destroy
  has_many :users, :through => :user_contests

  acts_as_indexed :fields => [:name, :description]
#  define_index do
#    indexes :name
#    indexes :description
#    has date_start, date_end
#  end

  def self.total_prize
    sum(:prize)
  end

  def winner
    user_contest = UserContest.find(:first, :select => "user_id", :conditions => ["rating_total=?",self.max_user_total_rating])
    unless user_contest.nil?
      User.find(user_contest.user_id)
    end
  end
end
