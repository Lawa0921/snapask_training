FactoryBot.define do
  factory :course do
    user
    name { Faker::Name.name }
    description { Faker::Lorem.word }
    price { Faker::Number.between(from: 1.00, to: 5000.00) }
    currency { Course.currencies.values.sample }
    type_of_course { Course.type_of_courses.values.sample }
    public { true }
    url { Faker::Internet.url }
    valididy_period { Faker::Number.between(from: 1.00, to: 30.00) }
  end
end
