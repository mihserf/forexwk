class PagesController < ApplicationController
  def show
    page = params[:id]
    @page = Page.find_by_permalink(params[:id])
	if File.exists?("#{RAILS_ROOT}/app/views/pages/#{page}.html.erb")

                render :action => page

                #redirect_to :action => page
        end

  end


  def home
    @page=Page.find_by_permalink("home")
  end

  def contacts
    @page=Page.find_by_permalink("contacts")
  end
end
