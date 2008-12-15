class Admin::CataloguesController < ApplicationController
  before_filter :admin_required
  def index
    @catalogues = Catalogue.all
  end

  def new
    @catalogue=Catalogue.new
  end

  def create
    @catalogue=Catalogue.new(params[:catalogue])


    if  @catalogue.save!
      unless params[:catalogue][:parent_id].empty?
        @catalogue.move_to_child_of Catalogue.find(params[:catalogue][:parent_id])
      end
      flash[:notice]="Каталог создан."
      redirect_to admin_catalogues_path
    else
      render :action => "new"
    end
  end

  def edit
    @catalogue=Catalogue.find(params[:id])
  end

  def update
    @catalogue=Catalogue.find(params[:id])
    unless @catalogue.parent_id==params[:catalogue][:parent_id] || params[:catalogue][:parent_id].empty?
      @catalogue.move_to_child_of Catalogue.find(params[:catalogue][:parent_id])
    end
    if params[:catalogue][:parent_id].empty? && @catalogue.parent_id!=nil
      @catalogue.move_to_root
    end

    # changing catalogue position in the siblings list
    unless params[:sortable_ids].empty?
      sortable_ids = params[:sortable_ids].split(',')
      unless @catalogue.id==sortable_ids.last.to_i

        new_neightbour = sortable_ids[sortable_ids.index(sortable_ids.find{|i| i.to_i==@catalogue.id})+1].to_i
        @catalogue.move_to_left_of Catalogue.find(new_neightbour)
      else
        new_neightbour = sortable_ids[sortable_ids.index(sortable_ids.find{|i| i.to_i==@catalogue.id})-1].to_i
        @catalogue.move_to_right_of Catalogue.find(new_neightbour)
      end
    end


    if  @catalogue.update_attributes(params[:catalogue])
      flash[:notice]="Каталог обновлен."
      redirect_to admin_catalogues_path
    end
  end

  def destroy
    @catalogue = Catalogue.find(params[:id])
    @catalogue.destroy
    respond_to do |format|
      format.html { redirect_to(admin_catalogues_url) }
      format.xml  { head :ok }
    end
  end
end
