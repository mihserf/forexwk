class ArticleIndication < ActiveRecord::Base
  belongs_to :article
  belongs_to :indication
end
