# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e54cad79f615eb124e73f11ebeb067cc'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 

  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  private
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
      #debugger
      current_user.admin?
    end

    def moderator?
      current_user.moderator?
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



end
