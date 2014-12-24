FactoryGirl.define do
  factory :user do
    sequence(:email)  { |n| "person_#{n}@example.com" }
    password "foobar11"
    password_confirmation "foobar11"
  end
end