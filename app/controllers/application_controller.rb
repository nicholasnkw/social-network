class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :redirect
  before_action :pending_friends

  protected

    def pending_friends
      if current_user
        @pending_friends = current_user.pending_friends
      end
    end
  
  # This is to redirect to the previously viewed page
    def redirect
      session[:return_to] ||= request.referer
    end
end
