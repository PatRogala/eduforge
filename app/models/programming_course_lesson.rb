# Represents a lesson within a programming course chapter
# == Schema Information
#
# Table name: programming_course_lessons
#
#  id                            :bigint           not null, primary key
#  title                         :string           not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  programming_course_chapter_id :bigint           not null
#
# Indexes
#
#  idx_on_programming_course_chapter_id_190b893302  (programming_course_chapter_id)
#
# Foreign Keys
#
#  fk_rails_...  (programming_course_chapter_id => programming_course_chapters.id) ON DELETE => cascade
#
class ProgrammingCourseLesson < ApplicationRecord
  belongs_to :programming_course_chapter
  has_rich_text :content
  has_one :programming_task, dependent: :destroy

  validates :title, presence: true

  delegate :programming_course, to: :programming_course_chapter

  def position
    programming_course_chapter.programming_course_lessons.order(:created_at).index(self) + 1
  end

  def approximate_duration_in_minutes
    return 0 if content.blank?

    content.to_plain_text.scan(/\w/).count / 150.0
  end
end
