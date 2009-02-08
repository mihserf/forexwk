class Article < ActiveRecord::Base
  belongs_to :catalogue
  belongs_to :user

  has_many :additions, :dependent => :destroy

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
  
  def has_additions?
    !additions.empty?
  end

  def sanitize
    self.content = Sanitize.clean(self.content, Sanitize::Config::RELAXED)
  end
end
