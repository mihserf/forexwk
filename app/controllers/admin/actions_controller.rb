class Admin::ActionsController < ApplicationController
  before_filter :admin_required


  def index
    @actions=Action.find(:all, :order => :name)
  end

  def new
    @action=Action.new
  end

  def create
    @action=Action.new(params[:action])

    if  @action.save!
      flash[:notice]="Акция создана."
      redirect_to admin_actions_path
    else
      render :action => "new"
    end
  end

  def edit
    @action=Action.find(params[:id])
  end

  def update
    @action=Action.find(params[:id])

    if  @action.update_attributes(params[:action])
      flash[:notice]="Акция обновлена"
      redirect_to admin_actions_path
    end
  end

  def destroy
    @action = Action.find(params[:id])
    @action.destroy
    respond_to do |format|
      format.html { redirect_to(admin_actions_url) }
      format.xml  { head :ok }
    end
  end

end
