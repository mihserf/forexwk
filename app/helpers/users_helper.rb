module UsersHelper
  def short_info(user)
    stat_rating_total = user.stat_rating_total_for_contest(@contest)
    stat_rating_avg = user.stat_rating.nil? ? 0 : user.stat_rating.rating_avg
    render :partial => "users/short_info", :locals => {:user=>user,:stat_rating_total=>stat_rating_total,:stat_rating_avg=>stat_rating_avg}
  end
end
