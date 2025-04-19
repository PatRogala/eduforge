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

  validates :title, presence: true

  delegate :programming_course, to: :programming_course_chapter

  def position
    programming_course_chapter.programming_course_lessons.order(:created_at).index(self) + 1
  end

  def approximate_duration_in_minutes
    return 0 if content.blank?

    content.to_plain_text.scan(/\w/).count / 150.0
  end

  def next_lesson
    next_in_chapter || first_lesson_in_next_chapter
  end

  private

  def next_in_chapter
    programming_course_chapter.programming_course_lessons
                              .where("created_at > ?", created_at)
                              .order(:created_at)
                              .first
  end

  def first_lesson_in_next_chapter
    next_chapter = programming_course.programming_course_chapters
                                     .where("created_at > ?", programming_course_chapter.created_at)
                                     .order(:created_at)
                                     .first

    return unless next_chapter

    next_chapter.programming_course_lessons.order(:created_at).first
  end
end
