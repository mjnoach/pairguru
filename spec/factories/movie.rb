FactoryBot.define do
  Movie.skip_callbacks = true

  factory :movie do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence(3, true) }
    released_at { Faker::Date.between(40.years.ago, Time.zone.today) }
    genre
    plot { Faker::Lorem.sentence(3, true) }
    rating { Faker::Number.between(1, 10) }
    poster_url { "https://pairguru-api.herokuapp.com/godfather.jpg" }

    trait :with_comments do
      after(:create) do |movie|
        create_list :comment, 10, movie: movie
      end
    end
  end
end
