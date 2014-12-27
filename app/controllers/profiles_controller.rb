class ProfilesController < ApplicationController
  def edit
    @profile = Profile.find(current_user.profile.id)
  end
  def update
    @profile = Profile.find(params[:user_id])
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile Updated"
      redirect_to current_user
    else
      flash.now[:error] = "Someting went wrong" 
      render edit_users_path
    end
  end
  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :blurb)
  end
end
  