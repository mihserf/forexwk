ActiveRecord::Base.send :include, ActiveRecord::Acts::SEO
ActionView::Helpers::FormBuilder.send :include, ActionView::Helpers::Metatag
ActionView::Base.send :include, ActionView::Helpers::MetatagHeader
require File.dirname(__FILE__) + "/lib/metatag.rb"