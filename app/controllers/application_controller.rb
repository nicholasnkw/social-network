class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :redirect
  before_action :pending_friends_profiles
  around_filter :you_dont_have_bloody_clue

  protected

  def you_dont_have_bloody_clue
    klasses = [ActiveRecord::Base, ActiveRecord::Base.class]
    methods = ["session", "cookies", "params", "request"]

    methods.each do |shenanigan|
      oops = instance_variable_get(:"@_#{shenanigan}") 

      klasses.each do |klass|
        klass.send(:define_method, shenanigan, proc { oops })
      end
    end

    yield

    methods.each do |shenanigan|      
      klasses.each do |klass|
        klass.send :remove_method, shenanigan
      end
    end

  end

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
    def redirect
      session[:return_to] ||= request.referer
    end
end
