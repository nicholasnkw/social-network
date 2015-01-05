class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end
  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to user_path(current_user)
    else
      render new_user_profiles
    end
  end
  def edit
    @profile = Profile.find(current_user.profile.id)
  end
  def update
    @profile = Profile.find(current_user.profile.id)
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile Updated"
      redirect_to current_user
    else
      flash.now[:error] = "Something went wrong" 
      render edit_user_profiles_path
    end
  end
  
  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :blurb, :photo,:user_id)
  end
end
  