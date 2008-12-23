class User < ActiveRecord::Base
  has_many :articles
  has_many :additions
  has_many :comments

  belongs_to :dealing_center

  validates_uniqueness_of :login

  acts_as_authentic

  has_attached_file :avatar,
                    :styles => { :thumb => ["29x29>",:jpg],
                                 :square => ["29x29#", :jpg],
                                 :normal  => ["150x150>",:jpg] }

  acts_as_rateable


  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  def name
    last_name+" "+first_name
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
end
