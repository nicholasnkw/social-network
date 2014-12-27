require 'spec_helper'

RSpec.describe User, :type => :model do
  before { @user = User.new(email: "user@example.com",
                            password: "12345678", password_confirmation: "12345678")}
  
  subject { @user }
  
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:profile) }
  it { should respond_to (:friends) }
  it { should respond_to (:pending_friends) }
  it { should respond_to (:requested_friends) }
  
  it { should be_valid}
  
  describe "friendships"
  let(:other_user) {FactoryGirl.create(:user)}
  
  
end
