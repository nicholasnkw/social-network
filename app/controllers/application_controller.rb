class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  before_action :pending_friends_profiles
  private
    def pending_friends
      if current_user
        @pending_friends = current_user.pending_friends
      end
    end
    def pending_friends_profiles
      if current_user
        @pending_friends = current_user.pending_friends
        @pending_friends_profiles = []
        @pending_friends.each do |p|
          @pending_friends_profiles << p.profile
        end
      end
    end
end
