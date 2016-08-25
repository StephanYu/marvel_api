FactoryGirl.define do
  factory :comic do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    marvel_comic_id { Faker::Number.number(5) }
    upvote { Faker::Number.number(2) }
    downvote { Faker::Number.number(2) }
    image_url { "#{Faker::Internet.url}/image.jpg" }
    thumbnail_url { "#{Faker::Internet.url}/thumbnail.jpg" }
  end

  trait :today do
    created_at Time.now
  end

  trait :yesterday do 
    created_at 1.day.ago
  end
end
