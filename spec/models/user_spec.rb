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
    
  
  it { should be_valid} 

  
  describe "Posts" do
    before do
      @post = Post.create(description: "This is a test post", author: @user)
      @like = Like.create(liker: @user, likeable_id: @post, likeable_type: "post")
      
    end
    its(:posts) { should include(@post) }
    
    describe "Liking a post" do
      it { should be_likes(@post)}
    end
    describe "Unliking a post" do
      before do
        @like.destroy
      end
      it { should_not be_likes(@post)}
    end 
    describe "commenting a post" do
      before { @comment = Comment.create(content: "This is a test comment", author: @user, commentable_id: @post, commentable_type: "post")}
        its(:comments) { should include(@comment)}
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
    
    describe "Requests" do
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
