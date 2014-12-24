require 'spec_helper'

RSpec.describe Profile, :type => :model do
  before { @profile = Profile.new(first_name: "test",
                                  last_name: "example",
                                  blurb: "This is a test",
                                  user_id: 1 )
    }

  
  subject { @profile }
  
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:blurb) }
  it { should respond_to(:user_id) }

  
  it { should be_valid}
end
