Array.class_eval do
    def paginate_result(page = 1, per_page = 15)
      WillPaginate::Collection.create(page, per_page, self.size) do |pager|
        pager.replace self[pager.offset, pager.per_page].to_a
      end
    end
  end

String.class_eval do
    def crop(str_size, omission = "...")
      chars = self.mb_chars
      ar = chars.split(" ")
      self.size.times do
        return ar.join(" ")+omission if ar.join(" ").mb_chars.length <= str_size-omission.mb_chars.length
        
        if ar.size==1
          ar[0]=ar[0][0..(str_size-omission.mb_chars.length)]
        else
          ar.slice!(-1)
        end
      end
      return ar.join(" ")+omission
    end
  end