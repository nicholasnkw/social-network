require 'spec_helper'

RSpec.describe Post, :type => :model do
  let(:post) {FactoryGirl.create(:post)}
  
  subject {post}
  
  it { should respond_to(:description) }
  it { should respond_to(:author) }
  it { should respond_to(:comments) }

  it { should be_valid }
  
  describe "when description is not present" do
    before { post.description = nil }
    it { should_not be_valid}
  end

end
