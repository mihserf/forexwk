class Indication < ActiveRecord::Base
  has_many :article_indications, :dependent => :destroy
  has_many :articles, :through => :article_indications

  def by_filter?
    !self.filter_id.blank?
  end
end
