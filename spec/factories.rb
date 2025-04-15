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

  factory :programming_course_lesson do
    title { Faker::Educator.subject }
    programming_course_chapter

    after(:build) do |lesson|
      lesson.content = ActionText::Content.new(Faker::Markdown.sandwich)
    end
  end

  factory :programming_course_chapter do
    title { Faker::Educator.course_name }
    programming_course
  end

  factory :programming_course_enrollment do
    user
    programming_course
  end
end
