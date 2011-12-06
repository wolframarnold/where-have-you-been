# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip do
    name 'Peru'
    user
  end

  factory :trip_with_places, :parent => :trip do
    places { [ FactoryGirl.build(:place, :trip => nil) ] }
  end
end

