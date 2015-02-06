require 'spec_helper'

describe "Post Pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, user_id: user.id, first_name: "David", last_name: "Janczyn") }
  let!(:p1) { FactoryGirl.create(:post, author: user, description: "This is a test")}
  before do 
    visit "/"  
    fill_in("user_email", :with => user.email)  
    fill_in("user_password", :with => "foobar11") 
    click_button("Log in") 
  end
  describe "index" do
    before do
      visit "/posts"
    end
    it { should have_content(p1) }
    describe "Only friends posts show" do
    end
  end
end