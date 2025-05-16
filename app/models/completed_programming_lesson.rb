# Tracks user completion of programming lessons
class CompletedProgrammingLesson < ApplicationRecord
  belongs_to :user
  belongs_to :programming_course_lesson

  validates :programming_course_lesson, uniqueness: { scope: :user }
  validate :user_is_enrolled_in_course

  private

  def user_is_enrolled_in_course
    errors.add(:base, "User is not enrolled in the course") unless user.enrolled_programming_courses.include?(programming_course_lesson.programming_course)
  end
end
