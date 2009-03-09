class Article < ActiveRecord::Base
  belongs_to :catalogue
  belongs_to :user

  has_many :additions, :dependent => :destroy
  has_many :article_indications, :dependent => :destroy
  has_many :indications, :through => :article_indications

  acts_as_rateable
  acts_as_taggable

  acts_as_indexed :fields => [:name, :content, :cached_tag_list]

  before_save :sanitize

#  acts_as_ferret :fields =>{:name=>{:boost=>4}, :content=>{}, :cached_tag_list=>{:boost=>3}},:store_class_name => true
#
#  define_index do
#    indexes :name
#    indexes :content
#    indexes [user.first_name, user.last_name, user.login], :as => :author
#    indexes additions.content, :as => :additions_content
#    has user_id, created_at, updated_at
#  end


  #acts_as_list :scope => :catalogue

  acts_as_seo

  BY_NAME = 1
  BY_DATE = 2
  BY_RATING = 3

  FILTER = {
    BY_NAME => {:title => "по названию", :order => "name ASC"},
    BY_DATE => {:title => "по дате", :order => "created_at DESC"},
    BY_RATING => {:title => "по рейтингу", :order => "stat_ratings.rating_avg DESC"}
  }


  def has_additions?
    !additions.empty?
  end

  def sanitize
    self.content = Sanitize.clean(self.content, Sanitize::Config::RELAXED)
  end

  def self.filter(filter_id=BY_DATE, limit=10)
    self.all(:limit => limit, :include => :stat_rating, :order => FILTER[filter_id][:order] )
  end
end
