class RatingsController < ApplicationController
  before_filter :get_master
  before_filter :require_user
  before_filter :admin_required, :only => :destroy
  def create
    unless @master.rated_by_user?(current_user) && !current_user.admin?
      if params[:rating].to_i.abs==1 || current_user.can_add_rating?(params[:rating])
        @master.add_rating(params[:rating],current_user)
        msg = "спасибо за оценку!"
      else
        msg = "Ваш рейтинг ещё не достаточен, чтобы ставить такую оценку"
      end
    else
      msg = "вы уже ставили оценку"
    end

    render :inline => msg

  end

  def destroy
      Rating.destroy(params[:id])
  end

  def get_master
    master_class = params.find{|k,v| k.include?"id"}[0].gsub("_id","").classify.constantize
    @master = master_class.find(params.find{|k,v| k.include?"id"}[1])
  end
end
