FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence(1, true) }
    movie 
    user { create(:user) }
  end
end