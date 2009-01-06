class ContestsController < ApplicationController
  def index
    @contests = Contest.find(:all, :order => "created_at DESC")
  end

  def users
    @contest = Contest.find(params[:id])
    @users = User.find(:all, :limit => 10, :joins =>:user_contests, :conditions =>["user_contests.contest_id=:contest_id",{:contest_id => @contest.id}], :order => "user_contests.rating_total DESC" )
  end

  def show
    @contest = Contest.find(params[:id]) rescue Contest.last
    @contests = Contest.find(:all, :order => "created_at DESC")
  end

end
