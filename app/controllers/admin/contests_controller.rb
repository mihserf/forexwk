class Admin::ContestsController < ApplicationController
  before_filter :admin_required


  def index
    @contests=Contest.find(:all, :order => :name)
  end

  def new
    @contest=Contest.new
  end

  def create
    @contest=Contest.new(params[:contest])

    if  @contest.save!
      flash[:notice]="Акция создана."
      redirect_to admin_contests_path
    else
      render :action => "new"
    end
  end

  def edit
    @contest=Contest.find(params[:id])
  end

  def update
    @contest=Contest.find(params[:id])

    if  @contest.update_attributes(params[:contest])
      flash[:notice]="Акция обновлена"
      redirect_to admin_contests_path
    end
  end

  def destroy
    @contest = Contest.find(params[:id])
    @contest.destroy
    respond_to do |format|
      format.html { redirect_to(admin_contests_url) }
      format.xml  { head :ok }
    end
  end

  def finish
    User.recount_rate
    @contest=Contest.find(params[:id])
    @contest.finished = true
    if @contest.save!
      flash[:notice]="Акция завершена. Баллы добавлены."
      redirect_to admin_contests_path
    end

  end
  

end
