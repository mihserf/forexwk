module ContestsHelper
  def contest_info(contest)
    contest_rules = Page.find_by_permalink("contest_rules").content
    top_users = User.top(contest.id).all(:limit => 5)
    users_number = User.count(:joins =>:user_contests, :conditions =>["user_contests.contest_id=:contest_id",{:contest_id => @contest.id}])
    render :partial => "contests/contest_info", :locals => { :contest_rules => contest_rules, :top_users => top_users, :contest => contest, :users_number => users_number }
  end
end
