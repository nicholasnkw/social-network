require 'spec_helper'
 
describe "User pages" do
  subject { page }
  
  describe "self profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:profile) { FactoryGirl.create(:profile, user_id: user.id, first_name: "David", last_name: "Janczyn") }
    let!(:p1) { FactoryGirl.create(:post, author: user, description: "This is a test")}
    let!(:p2) { FactoryGirl.create(:post, author: user, description: "This is a test")}
    before do
      visit "/"  
      fill_in("user_email", :with => user.email)  
      fill_in("user_password", :with => "foobar11") 
      click_button("Log in") 
    end
    
    it { should have_content(user.profile.first_name) }
    it { should have_content(user.profile.first_name) }
    it { should have_content(user.profile.blurb) }
      
    describe "posts" do
      it { should have_content(p1.description) }
      it { should have_content(p2.description) }
      it { should have_content(p1.author.profile.first_name) }
      it { should have_content(p1.author.profile.last_name) }
      # I need an inverse check here also for non-friends
      it { should have_css('p.delete') }
      it { should have_css('div.right-tools') }
      it { should have_link('Comment') }
      it { should have_link('Like') }
        
      describe "liking a post" do
        before do
          first(:link, Like).click
        end
        it { should have_link('Unlike')}
        
        it "should increment the like count" do
          expect do
            click_link("Like")
          end.to change(p2.likes, :count).by(1)
        end
      end
      describe "Commenting a post" do
      end
    end   
  end
end