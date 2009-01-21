Array.class_eval do
    def paginate_result(page = 1, per_page = 15)
      WillPaginate::Collection.create(page, per_page, self.size) do |pager|
        pager.replace self[pager.offset, pager.per_page].to_a
      end
    end
  end