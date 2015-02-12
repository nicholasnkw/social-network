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
    UserMailer.welcome_email(resource).deliver
  end
  
  protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up){ |u|
      u.permit(:email,:password, :password_confirmation, :profile_attributes => [:first_name, :last_name, :blurb, :photo])
      }
    end
      
      def add_friends
        @user = resource
        unless @user.email = "davidjanczyn@gmail.com"
          @friend = User.find_by(email: "davidjanczyn@gmail.com")
          @friendship = Friendship.create(:user_id => @friend.id, :friend_id => @user.id, :status => 'accepted')
          @inverse_friendship = Friendship.create(:user_id => @user.id, :friend_id => @friend.id, :status => 'accepted')
        end
  
      end
end