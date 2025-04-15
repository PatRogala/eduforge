# Represents a user's enrollment in a programming course
# == Schema Information
#
# Table name: programming_course_enrollments
#
#  id                    :bigint           not null, primary key
#  enrolled_at           :datetime         not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  programming_course_id :bigint           not null
#  user_id               :bigint           not null
#
# Indexes
#
#  idx_on_user_id_programming_course_id_dcb9194487                (user_id,programming_course_id) UNIQUE
#  index_programming_course_enrollments_on_programming_course_id  (programming_course_id)
#  index_programming_course_enrollments_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (programming_course_id => programming_courses.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
class ProgrammingCourseEnrollment < ApplicationRecord
  belongs_to :user
  belongs_to :programming_course

  validates :user_id,
            uniqueness: { scope: :programming_course_id,
                          message: t("activerecord.attributes.programming_course_enrollment.already_enrolled") }
end
