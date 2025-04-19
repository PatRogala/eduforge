# Represents a programming task within a lesson
# == Schema Information
#
# Table name: programming_tasks
#
#  id                           :bigint           not null, primary key
#  difficulty_level             :string           not null
#  hints                        :text             default([]), is an Array
#  initial_code                 :text             not null
#  points                       :integer          default(0), not null
#  solution_code                :text             not null
#  test_cases                   :jsonb            not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  programming_course_lesson_id :bigint           not null
#
# Indexes
#
#  index_programming_tasks_on_difficulty_level              (difficulty_level)
#  index_programming_tasks_on_points                        (points)
#  index_programming_tasks_on_programming_course_lesson_id  (programming_course_lesson_id)
#
# Foreign Keys
#
#  fk_rails_...  (programming_course_lesson_id => programming_course_lessons.id)
#
class ProgrammingTask < ApplicationRecord
  belongs_to :programming_course_lesson

  DIFFICULTY_LEVELS = %w[easy medium hard].freeze

  validates :initial_code, presence: true
  validates :solution_code, presence: true
  validates :test_cases, presence: true
  validates :difficulty_level, presence: true, inclusion: { in: DIFFICULTY_LEVELS }
  validates :points, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :time_limit, numericality: { greater_than: 0 }, allow_nil: true

  def self.difficulty_levels
    DIFFICULTY_LEVELS
  end
end
