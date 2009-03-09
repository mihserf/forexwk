class Admin::ArticleIndicationsController < ApplicationController
  def create
    ArticleIndication.find_or_create_by_indication_id_and_article_id(params[:indication_id], params[:article_id]) unless params[:indication_id].blank? || params[:article_id].blank?

    respond_to do |format|
      format.html{ redirect_to admin_articles_path }
      format.js{ render :inline => "created" }
    end
  end

  def destroy
    ArticleIndication.delete_all({:indication_id => params[:indication_id], :article_id => params[:article_id]}) unless params[:indication_id].blank? || params[:article_id].blank?

    respond_to do |format|
      format.html{ redirect_to admin_articles_path }
      format.js{ render :inline => "destroied"  }
    end
  end
end
