FactoryBot.define do
  factory :course do
    user
    name { Faker::Name.name }
    description { Faker::Lorem.word }
    price { Faker.Nunber.between(from = 1, to = 5000) }
    currency { Course.currencies.values.sample }
    type_of_course { Course.type_of_courses.values.sample }
    public { true }
    url { Faker::Internet.url }
    valididy_period { Faker.Nunber.between(from = 1, to = 30) }
  end
end
