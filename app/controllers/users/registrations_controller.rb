class Users::RegistrationsController < Devise::RegistrationsController
  
  before_filter :configure_permitted_parameters
  
  def new
    build_resource({})
    resource.build_profile
    respond_with self.resource
  end

  
  protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up){ |u|
      u.permit(:email,:password, :password_confirmation, :profile_attributes => [:first_name, :last_name, :blurb, :photo])
      }
    end
end