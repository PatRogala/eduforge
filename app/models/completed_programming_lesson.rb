# Tracks user completion of programming lessons
class CompletedProgrammingLesson < ApplicationRecord
  belongs_to :user
  belongs_to :programming_course_lesson

  validates :programming_course_lesson, uniqueness: { scope: :user }

  delegate :programming_course, to: :programming_course_lesson
end
