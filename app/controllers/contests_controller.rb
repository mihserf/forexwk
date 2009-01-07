class ContestsController < ApplicationController
  def index
    @contests = Contest.find(:all, :order => "created_at DESC")
  end

  def show
    @contest = Contest.find(params[:id])
    @contests = Contest.find(:all, :order => "created_at DESC")
    @top_users = User.top(@contest.id).all(:limit => 5)
    @total_prize = Contest.total_prize
    @rules = Page.find_by_permalink("contest_rules")
  end

  def users
    @contest = Contest.find(params[:id])
    @users = User.find(:all, :limit => 10, :joins =>:user_contests, :conditions =>["user_contests.contest_id=:contest_id",{:contest_id => @contest.id}], :order => "user_contests.rating_total DESC" )
    @users = User.paginate(:page => params[:page], :per_page => 30, :joins =>:user_contests, :conditions =>["user_contests.contest_id=:contest_id",{:contest_id => @contest.id}], :order => "user_contests.rating_total DESC")
  end

  def archive
    @contests = Contest.paginate(:page => params[:page], :per_page => 2, :conditions => ["date_end < ?",Date.today.to_date])
    render :partial => "/contests/archive", :locals => {:contests => @contests}
  end

end
