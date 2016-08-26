FactoryGirl.define do
  factory :character do
    name { Faker::Lorem.name }
  end
end
