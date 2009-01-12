module ContestsHelper
  def contest_info(contest)
    top_users = User.top(contest.id).all(:limit => 5)
    users_number = User.count(:joins =>:user_contests, :conditions =>["user_contests.contest_id=:contest_id",{:contest_id => @contest.id}])
    render :partial => "contests/contest_info", :locals => { :top_users => top_users, :contest => contest, :users_number => users_number }
  end
end
