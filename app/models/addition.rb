class Addition < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  has_many :comments, :dependent => :destroy

  acts_as_rateable

  after_create :increase_stat_additions_of_article
  before_destroy :decrease_stat_additions_of_article

  def increase_stat_additions_of_article
    @article = article
    @article.stat_additions+=1
    @article.save
  end
  def decrease_stat_additions_of_article
    @article = article
    @article.stat_additions-=1
    @article.save
  end
end
