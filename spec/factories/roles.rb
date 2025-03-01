# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_roles_on_name  (name) UNIQUE
#
FactoryBot.define do
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
