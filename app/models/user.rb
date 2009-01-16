class User < ActiveRecord::Base
  include SavageBeast::UserInit

  has_many :articles
  has_many :additions
  has_many :comments

  has_many :user_contests, :dependent => :destroy
  has_many :contests, :through => :user_contests

  has_one :messaging_rule

  belongs_to :dealing_center

  validates_uniqueness_of :login, :message => "Извините, но этот логин занят"
  validates_uniqueness_of :login, :message => "Извините, но этот email занят"
  validates_presence_of :login, :message => "Логин необходим для регистрации"
  validates_presence_of :password, :message => "Пароль необходим для регистрации", :on => :create
  validates_presence_of :email, :message => "E-mail необходим для регистрации"





  acts_as_authentic
  acts_as_indexed :fields => [:first_name, :last_name, :login]
  #acts_as_ferret :fields => {:first_name=>{}, :last_name=>{}, :login=>{}},:store_class_name => true
  acts_as_rateable

  has_attached_file :avatar,
                    :styles => { :thumb => "29x29>",
                                 :square => ["29x29#", :jpg],
                                 :normal  => "150x150>" },
                    :url => "/attachments/:class/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/attachments/:class/:id/:style_:basename.:extension"

  named_scope :top, lambda { |contest_id|
    {:joins => :user_contests, :conditions =>["user_contests.contest_id=:contest_id",{:contest_id => contest_id}], :order => "user_contests.rating_total DESC" }
  }


  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  def name
    (last_name || "")+" "+(first_name || "")
  end

  def name_or_login
    show_name? ? name : login
  end

  # Cheks if user has enaugh own rating to rate objects with such rate value. Anyway user can add rating -1 to 1.  Admin can add any possible rating
  # ==Params
  # val - rating value.
  # ==Usage
  # current_user.can_add_rating? 5
  def can_add_rating?(val)
    return true if admin || (val.abs>=0 && val.abs<=1)
    stat_rating.nil? ? false : stat_rating.rating_total.abs >= val.to_i.abs
  end

  def stat_ratings_for_contest(contest=current_contest)
    UserContest.find(:first, :select => "rating_total, rating_avg, articles, additions", :conditions => ["user_id = :user_id AND contest_id = :contest_id",{:user_id => id, :contest_id => contest.id}])
  end

  def articles_for_contest(contest=current_contest)
    stat_ratings_for_contest(contest).articles rescue 0
  end

  def additions_for_contest(contest=current_contest)
    stat_ratings_for_contest(contest).additions rescue 0
  end

  def percent_rating_for_contest(contest=current_contest)
    ((stat_rating_total_for_contest(contest).to_f/contest.max_user_total_rating.to_f)*100).round rescue 0
  end

  def stat_rating_total_for_contest(contest=current_contest)
       stat_ratings_for_contest(contest).rating_total rescue 0
  end

  def stat_rating_avg_for_contest(contest=current_contest)
       stat_ratings_for_contest(contest).rating_avg rescue 0
  end

  def rating_for_contest(contest=current_contest)
    rating_in_dates(contest.date_start,contest.date_end)
  end

end
