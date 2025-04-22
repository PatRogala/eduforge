# Represents a programming task within a lesson
# == Schema Information
#
# Table name: programming_tasks
#
#  id                           :bigint           not null, primary key
#  difficulty                   :string           not null
#  hints                        :jsonb            not null
#  initial_code                 :text             not null
#  language                     :string           not null
#  solution_code                :text             not null
#  test_cases                   :jsonb            not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  programming_course_lesson_id :bigint           not null
#
# Indexes
#
#  index_programming_tasks_on_difficulty  (difficulty)
#  unique_programming_task_per_lesson     (programming_course_lesson_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (programming_course_lesson_id => programming_course_lessons.id)
#
class ProgrammingTask < ApplicationRecord
  belongs_to :programming_course_lesson

  enum :difficulty, { easy: "easy", medium: "medium", hard: "hard" }, prefix: true

  validates :initial_code, presence: true
  validates :solution_code, presence: true
  validates :test_cases, presence: true
  validates :difficulty, presence: true
  validates :language, presence: true
  validates :programming_course_lesson_id, uniqueness: true

  before_validation :set_language

  private

  def set_language
    self.language = "ruby"
  end
end
