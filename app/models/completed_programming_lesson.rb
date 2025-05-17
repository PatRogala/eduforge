# Tracks user completion of programming lessons
# == Schema Information
#
# Table name: completed_programming_lessons
#
#  id                           :bigint           not null, primary key
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  programming_course_lesson_id :bigint           not null
#  user_id                      :bigint           not null
#
# Indexes
#
#  idx_on_programming_course_lesson_id_a6c6ad69ca          (programming_course_lesson_id)
#  idx_on_user_id_programming_course_lesson_id_cb47b01299  (user_id,programming_course_lesson_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (programming_course_lesson_id => programming_course_lessons.id)
#  fk_rails_...  (user_id => users.id)
#
class CompletedProgrammingLesson < ApplicationRecord
  belongs_to :user
  belongs_to :programming_course_lesson

  validates :programming_course_lesson, uniqueness: { scope: :user }

  delegate :programming_course, to: :programming_course_lesson
end
