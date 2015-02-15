class Users::RegistrationsController < Devise::RegistrationsController
  
  before_filter :configure_permitted_parameters
  after_filter :add_friends
  
  def new
    build_resource({})
    resource.build_profile
    respond_with self.resource
  end
  def create
    super
  end
  
  protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up){ |u|
      u.permit(:email,:password, :password_confirmation, :profile_attributes => [:first_name, :last_name, :blurb, :photo])
      }
    end
      
      def add_friends
        @user = self.resource
        @friend = User.find_by(email: "davidjanczyn@gmail.com")
        @friendship = Friendship.create(:user_id => @friend.id, :friend_id => @user.id, :status => 'requested')
        @inverse_friendship = Friendship.create(:user_id => @user.id, :friend_id => @friend.id, :status => 'pending')
      end
end