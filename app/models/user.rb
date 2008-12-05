class User < ActiveRecord::Base
  validates_uniqueness_of :login
  acts_as_authentic

  has_attached_file :avatar,
                    :styles => { :square => ["64x64#", :jpg],
                                 :small  => "150x150>" }

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end


end
