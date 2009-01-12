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

    #contests block
    @contest = current_contest || Contest.find(:first, :order => "date_end DESC").id
    @top_users = User.top(@contest.id).all(:limit => 5)

    #dealing_centers block
    @dealing_centers = DealingCenter.find(:all, :limit => 20,:conditions=>["temp=?",false], :order => "name DESC")

    #events block
    @events = Event.find(:all, :limit => 5, :order => "created_at DESC")

    #books block
    @leader_book = Book.find(:first, :conditions => ["leader=?", true], :order => "updated_at DESC")
    @fresh_books = Book.all(:limit => 4, :order => "created_at DESC" )
  end

  def contacts
    @page=Page.find_by_permalink("contacts")
  end
end
