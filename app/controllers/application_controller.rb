# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :tags
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e54cad79f615eb124e73f11ebeb067cc'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 

  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user, :current_contest, :logged_in?, :admin?, :moderator?


  def tags
    @tags = Article.tag_counts
  end

  private

    def current_contest
      return @current_contest if defined?(@current_contest)
      @current_contest = Contest.find(:first, :conditions => ["date_start<='#{Time.now.to_date}' AND '#{Time.now.to_date}'<=date_end"])
    end

    def admin_required
      if current_user && admin?
        return true
      else
        store_location
        flash[:notice] = "Должены иметь соответствующие права для доступа к этой странице"
        redirect_to new_user_session_url
      end
    end

    def moderator_required
      require_user

      if current_user && moderator?
        return true
      else
        store_location
        flash[:notice] = "Должены иметь соответствующие права для доступа к этой странице"
        redirect_to new_user_session_url
      end
    end

    def admin?
      current_user && current_user.admin?
    end

    def moderator?
      current_user && current_user.moderator?
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "Вы должны быть залогинены, для доступа к этой странице"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "Вы должны быть залогинены, для доступа к этой странице"
        redirect_to account_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    # FORUM methods:

    # this is used to keep track of the last time a user has been seen (reading a topic)
    # it is used to know when topics are new or old and which should have the green
    # activity light next to them
    #
    # we cheat by not calling it all the time, but rather only when a user views a topic
    # which means it isn't truly "last seen at" but it does serve it's intended purpose
    #
    # this could be a filter for the entire app and keep with it's true meaning, but that 
    # would just slow things down without any forseeable benefit since we already know 
    # who is online from the user/session connection 
    #
    # This is now also used to show which users are online... not at accurate as the
    # session based approach, but less code and less overhead.
    def update_last_seen_at
      return unless logged_in?
      User.update_all ['last_seen_at = ?', Time.now.utc], ['id = ?', current_user.id] 
      current_user.last_seen_at = Time.now.utc
    end
    
    def login_required
      require_user
      #attempt_login
      #respond_to do |format| 
      #  format.html { redirect_to login_path }
      #  format.js   { render(:update) { |p| p.redirect_to login_path } }
      #  format.xml  do
      #    headers["WWW-Authenticate"] = %(Basic realm="Beast")
      #    render :text => "HTTP Basic: Access denied.\n", :status => :unauthorized
      #  end
      #end unless logged_in? && authorized?
    end
    
    def authorized?() 
	    admin? 
	    # in your code, redirect to an appropriate page if not an admin
    end
    
    def logged_in?
      #defined?(@current_user)
      current_user
      #current_user != 0
    end


end
