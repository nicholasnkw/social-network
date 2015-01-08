FactoryGirl.define do  factory :image do
    
  end

  factory :user do
    sequence(:email)  { |n| "person_#{n}@example.com" }
    password "foobar11"
    password_confirmation "foobar11"
  end
  factory :profile do
    sequence(:first_name) { |n| "David#{n}"}
    sequence(:last_name) { |n| "Janczyn#{n}"}
    sequence(:user_id) { |n| n }
  end
  factory :post do 
    description "This is a test"
    sequence(:author_id) { |n| n}
  end
end