# Role of a user, e.g. admin, instructor
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
class Role < ApplicationRecord
  ADMIN_ID = 1
  INSTRUCTOR_ID = 2

  has_many :user_roles, dependent: :delete_all
  has_many :users, through: :user_roles

  validates :name, presence: true, uniqueness: true
end
