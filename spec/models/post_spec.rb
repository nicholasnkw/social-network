require 'spec_helper'

RSpec.describe Post, :type => :model do
  let(:post) {FactoryGirl.create(:post)}
  
  subject {post}
  
  it { should respond_to(:description) }
  it { should respond_to(:author_id) }


end
