# Represents a user (client) in system
# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  has_many :user_roles, dependent: :delete_all
  has_many :roles, through: :user_roles
  has_many :programming_courses, foreign_key: :instructor_id, inverse_of: :instructor, dependent: :destroy
  has_many :programming_course_enrollments, dependent: :delete_all
  has_many :enrolled_programming_courses, through: :programming_course_enrollments, source: :programming_course
  has_many :completed_programming_lessons, dependent: :delete_all
  has_one_attached :avatar

  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def instructor?
    roles.ids.include?(Role::INSTRUCTOR_ID)
  end

  def admin?
    roles.ids.include?(Role::ADMIN_ID)
  end

  def enrolled_in_programming_courses?(programming_course)
    programming_course_enrollments.exists?(programming_course: programming_course)
  end

  def completed_lesson?(lesson)
    completed_programming_lessons.exists?(programming_course_lesson: lesson)
  end
end
