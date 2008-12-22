class Comment < ActiveRecord::Base
  belongs_to :addition
  belongs_to :user

  after_create :increase_stat_comments
  before_destroy :decrease_stat_comments

  def increase_stat_comments
    @addition = addition
    @addition.stat_comments+=1
    @addition.save

    @article = addition.article
    @article.stat_comments+=1
    @article.save
  end
  def decrease_stat_comments
    @addition = addition
    @addition.stat_comments-=1
    @addition.save

    @article = addition.article
    @article.stat_comments-=1
    @article.save
  end
  
end
