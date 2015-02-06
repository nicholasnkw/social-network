require 'spec_helper'
 
describe "User pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user)}
  let!(:profile) { FactoryGirl.create(:profile, user_id: user.id, first_name: "David", last_name: "Janczyn")}
  before do 
    visit "/"  
    fill_in("user_email", :with => user.email)  
    fill_in("user_password", :with => "foobar11") 
    click_button("Log in") 
  end
  describe "index" do
    before do
      2.times do
        FactoryGirl.create(:user)
        FactoryGirl.create(:profile)
      end
      visit "/users"
    end
    it { should have_content("Users")}
  end
  
  describe " profile" do
    before { visit "/"}
     it { should have_content("#{user.profile.first_name} #{user.profile.last_name}") }
    it { should have_content(user.profile.blurb) }
  end

  describe "index" do

  end
  
  
 
end