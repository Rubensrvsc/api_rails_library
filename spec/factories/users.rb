FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Lorem.unique.exclude :string, [number: 6], %w[wxcvbn] }
  end
end
