FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "joe#{n}@example.com"}
    password 'password'
    password_confirmation 'password'
  end
end
