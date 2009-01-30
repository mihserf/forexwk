module ActiveRecord
  module Acts
    module SEO
      def self.included(base)
        base.extend(ClassMethods)
      end
  
      module InstanceMethods
        attr_accessor :metatag_title, :metatag_description, :metatag_keywords
        
        def create_metatags
      	  build_metatag(:title => @metatag_title, 
      	                :keywords => @metatag_keywords, 
      	                :description => @metatag_description)
      	end
      	
        def update_metatags
            metatag.update_attributes(:title => @metatag_title, 
                                      :keywords => @metatag_keywords, 
                                      :description => @metatag_description)
          rescue
            create_metatags
        end
        
        def metatag_title
            metatag.title rescue @metatag_title
        end
        
        def metatag_description
            metatag.description rescue @metatag_description
        end
        
        def metatag_keywords
          metatag.keywords rescue @metatag_keywords
        end
        
        def metatags
          mt = []
          mt << ['description', metatag.description] rescue nil
          mt << ['keywords', metatag.keywords] rescue nil
          mt
        end

      end
      
      module ClassMethods
        def acts_as_seo
          include ActiveRecord::Acts::SEO::InstanceMethods
          
          before_create :create_metatags
          before_update :update_metatags
          has_one :metatag, :as => :metatagable
      	end
      end
  
    end
  end
end