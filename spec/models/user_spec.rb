require 'rails_helper'

RSpec.describe User, :type => :model do
  before { @user = User.new(email: "user@example.com",
                            password: "foobar", password_confirmation: "foobar")}
  
  subject { @user }
  
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it {should respond_to(:password_confirmation) }
  
  it { should be_valid}
end
