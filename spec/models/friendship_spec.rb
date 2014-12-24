require 'spec_helper'

describe Friendship do

  let(:user) { FactoryGirl.create(:user) }
  let(:friend) { FactoryGirl.create(:user) }
  let(:friendship) { user.friendships.build(user_id: user.id, friend_id: friend.id, status: "requested") }

  subject { friendship } 

  it { should respond_to(:user) }
  it { should respond_to(:friend) }
  it { should be_valid }
  
  describe "when user id id is not present" do
    before { friendship.user_id = nil}
    it { should_not be_valid}
  end

    
  describe "when friend id is not present" do
    before { friendship.friend_id = nil}
    it { should_not be_valid}
  end
  
  describe "when status is not present" do
    before {friendship.status = nil}
    it {should_not be_valid}
  end

end
