class AdditionsController < ApplicationController
  before_filter :require_user, :only => [:create,:update]
  before_filter :moderator_required, :only => :destroy
  def create
    @addition = Addition.new(params[:addition])
    @addition.article_id = params[:article_id]
    @addition.user_id = current_user.id
    @addition.build_stat_rating(:rating_avg => 0,:rating_total => 0)

    if @addition.save
      flash[:notice] = "Спасибо за дополнение!"
      redirect_back_or_default user_article_path(current_user,params[:article_id])
    else
      flash[:error] = "Ошибка при сохранении дополнения"
      redirect_back_or_default user_article_path(current_user,params[:article_id])
    end
  end

  def update
    @addition = Addition.find(params[:id])
    if  @addition.update_attributes(params[:addition])
      flash[:notice]="Дополнение обновлено."
      redirect_back_or_default user_article_path(current_user,params[:article_id])
    end
  end

  def destroy
    Addition.destroy(params[:id])
    render :inline => "Дополнение удалено"
  end
end
