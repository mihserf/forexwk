module RatingsHelper
  # rate helper. Add rate links in the view. Depends from associated rateable object and max value of rating
  # ==Params
  # obj - rated object,
  # max_value - absolute max rating value.
  # ==Usage
  # <%= rate(@article,5) %> will generate links with value from -5 to 5, and activited will be only accorded to current user own rating
  def rate(obj,max_value)
    if obj.rated_by_user?(current_user) && !current_user.admin?
      return "Вы уже ставили оценку"
    end
    
    links=""
    (-max_value).upto(max_value) do |i|
      link_name = (i>0 ? "+":"")+i.to_s
      if current_user.can_add_rating?(i) || current_user.admin?
        links += link_to(link_name, eval("#{obj.class.to_s.underscore}_ratings_path(#{obj.id},:rating=>#{i})"), :class => "rate")  unless i==0
      else
      links +="<span class='rate'>"+link_name+"</span>" unless i==0
      end
    end
    links
  end
end
