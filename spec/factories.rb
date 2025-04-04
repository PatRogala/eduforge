FactoryBot.define do
  factory :programming_course do
    title { Faker::Lorem.unique.word }
    cover_image { Rails.root.join("spec/fixtures/files/test.jpeg") }
  end

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    reset_password_token { nil }
  end

  factory :user_role do
    user { nil }
    role { nil }
  end

  factory :role do
    name { Faker::Lorem.word }

    trait :admin do
      id { 1 }
      name { "Admin" }
    end

    trait :instructor do
      id { 2 }
      name { "Instructor" }
    end
  end
end
