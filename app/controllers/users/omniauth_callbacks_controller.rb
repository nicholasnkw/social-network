class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    
    if @user.persisted?
      if cookies[:oafb] == true
         cookies[:oafb] = nil
        sign_in @user
        redirect_to new_user_profiles_path(current_user)
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        sign_in_and_redirect @user
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      end
    else 
      render :text => request.env["omniauth.auth"].to_yaml
    end
  end
end
