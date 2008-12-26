class CommentsController < ApplicationController
  before_filter :require_user, :only => [:create,:update]
  before_filter :moderator_required, :only => :destroy
  def index
    @comments = Comment.find(:all, :include => :user, :conditions => ["addition_id=:addition_id",{:addition_id=>params[:addition_id]}], :order => "created_at")
#    render :update do |page|
#      page << render
#    end

    render :action => "index", :layout => false
    
    #render :json => @comments.to_json(:include => {:user=>{:only=>[:first_name,:last_name,:id]}})
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.addition_id = params[:addition_id]
    @comment.user_id = current_user.id

    if @comment.save
      Notifier.deliver_message_comment_added(@comment.addition.article.user, @comment)
      Notifier.deliver_message_to_moderator_new_comment(@comment)
      flash[:notice] = "Спасибо за комментарий!"
      redirect_back_or_default user_articles_path(current_user)
    else
      flash[:error] = "Ошибка при сохранении комментария"
      redirect_back_or_default user_articles_path(current_user)
    end
  end

  def update
    @comment = Commentn.find(params[:id])
    if  @comment.update_attributes(params[:comment])
      flash[:notice]="Комментарий обновлен."
      redirect_back_or_default user_articles_path(current_user)
    end
  end

  def destroy
    Comment.destroy(params[:id])
    render :inline => "Комментарий удалён"
  end
end
