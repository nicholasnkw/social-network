require 'spec_helper'

RSpec.describe User, :type => :model do
  
  before { @user = User.new(email: "user@example.com",
                            password: "12345678", password_confirmation: "12345678")}
  subject { @user }
  
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:profile) }
  it { should respond_to(:friends) }
  it { should respond_to(:pending_friends) }
  it { should respond_to(:requested_friends) }
  it { should respond_to(:posts) }
  it { should respond_to(:comments) }  
  it { should respond_to(:likes?) }
  it { should respond_to(:likes)}
  it { should respond_to(:liked_things) }
  it { should have_many(:servers).dependent(:destroy) }
    
  
  it { should be_valid} 

  
  describe "Posts" do
    before do
      @post = Post.new(description: "This is a test", author: @user)
      @post.save
    end
    its(:posts) { should include(@post) }
    
    describe "Liking a post" do
      before do
        @like = Like.create(liked: @post, liker: @user)
      end
      it { should be_likes(@post)}
      describe "Unliking a post" do
        before do
          @like.destroy
        end
        it { should_not be_likes(@post)}
      end
    end
    
    describe "Dependent Post gets destroyed" do
      before do
        @user.save
        @user.destroy
      end
      
    end
    
  end
  
  describe "Relationships" do

    let(:other_user) {FactoryGirl.create(:user) }
      before do
        @user.save
        @friendship = Friendship.new(user: @user, friend: other_user, status: "accepted")
        @friendship.save
      end
    describe "Friends" do
      its(:friends) { should include(other_user) }
      its(:requested_friends) { should_not include(other_user) }
      its(:pending_friends) { should_not include(other_user) }
    end
    
    describe "Request" do
      before {@friendship.update_attributes(status: "requested")}
      its(:requested_friends) { should include(other_user) }
      its(:pending_friends) { should_not include(other_user) }
      its(:friends) { should_not include(other_user)}
    end
    
    describe "Pending" do
      before {@friendship.update_attributes(status: "pending")}
      its(:pending_friends) { should include(other_user) }
      its(:friends) { should_not include(other_user) }
      its(:requested_friends) { should_not include(other_user) }
      
    end
  end
end
