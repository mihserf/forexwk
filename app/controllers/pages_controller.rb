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

    # contests block
    @contest = current_contest || Contest.find(:first, :order => "date_end DESC")
    @top_users = User.top(@contest.id).all(:limit => 5)

    #indications block
    @indications = Indication.all(:include => :articles, :order => :number)

    #dealing_centers block
    @dealing_centers = DealingCenter.find_by_sql(" SELECT dc.id AS id, dc.name AS name, dc.url AS url, dc.commerce AS commerce FROM dealing_centers dc LEFT JOIN users u ON dc.id = u.dealing_center_id WHERE temp=false GROUP BY dc.name ORDER BY dc.commerce DESC, COUNT( dc.id ) DESC , dc.name LIMIT 0 , 30 ")
    #@dealing_centers = DealingCenter.find(:all, :limit => 20,  :conditions=>["temp=?",false], :joins => :users, :group => "dealing_centers.id", :order => "count(dealing_centers.id) DESC, dealing_centers.name")
    #events block
    @events = Event.find(:all, :limit => 5, :order => "created_at DESC")

    #books block
    @fresh_books = Book.all(:limit => 4, :order => "created_at DESC" )
    @leader_book = Book.find(:first, :conditions => ["leader=?", true], :order => "updated_at DESC") || @fresh_books.first

  end

  def contacts
    @page=Page.find_by_permalink("contacts")
  end
end
