class RatingsController < ApplicationController
  before_filter :get_master
  before_filter :require_user
  before_filter :admin_required, :only => :destroy
  def create
    data ={"msg"=>nil,"rating_avg"=>nil,"rating_total"=>nil}
    
    unless @master.rated_by_user?(current_user) && !current_user.admin?
      if params[:rating].to_i.abs==1 || current_user.can_add_rating?(params[:rating])
        @master.add_rating(params[:rating],current_user)
        data["rating_avg"]=@master.stat_rating.rating_avg
        data["rating_total"]=@master.stat_rating.rating_total
        data["msg"] = "спасибо за оценку!"
      else
        data["msg"] = "Ваш рейтинг ещё не достаточен, чтобы ставить такую оценку"
      end
    else
      data["msg"] = "вы уже ставили оценку"
    end

    render :json => data.to_json

  end

  def destroy
      Rating.destroy(params[:id])
  end

  def get_master
    master_class = params.find{|k,v| k.include?"id"}[0].gsub("_id","").classify.constantize
    @master = master_class.find(params.find{|k,v| k.include?"id"}[1])
  end
end
