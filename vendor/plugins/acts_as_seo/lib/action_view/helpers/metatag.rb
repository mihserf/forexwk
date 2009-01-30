module ActionView
  module Helpers
    module Metatag
      def metatag_title(method=:metatag_title, options = {})
        InstanceTag.new(@object_name, method, self, nil, options.delete(:object)).to_input_field_tag("text", options)
      end
      
      def metatag_keywords(method=:metatag_keywords, options = {})
        InstanceTag.new(@object_name, method, self, nil, options.delete(:object)).to_input_field_tag("text", options)
      end
      
      def metatag_description(method=:metatag_description, options = {})
        InstanceTag.new(@object_name, method, self, nil, options.delete(:object)).to_text_area_tag(options)
      end
    end
    
    module MetatagHeader
      def metatags(object)
        object.metatags.map do |name, content|
          "<meta name=\"#{name}\" content=\"#{content}\" />"
        end.join("\n")
      end
      
      def metatag_title(object, title="", separator="|")
        if object.metatag_title
          "#{title} #{separator} #{object.metatag_title}"
        else
          title
        end
      end
    end
  end
end