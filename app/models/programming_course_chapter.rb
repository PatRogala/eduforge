# == Schema Information
#
# Table name: programming_course_chapters
#
#  id                    :bigint           not null, primary key
#  title                 :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  programming_course_id :bigint           not null
#
# Indexes
#
#  index_programming_course_chapters_on_programming_course_id  (programming_course_id)
#
# Foreign Keys
#
#  fk_rails_...  (programming_course_id => programming_courses.id) ON DELETE => cascade
#
class ProgrammingCourseChapter < ApplicationRecord
  belongs_to :programming_course
  has_many :programming_course_lessons, dependent: :destroy

  validates :title, presence: true

  def position
    programming_course.programming_course_chapters.order(:created_at).index(self) + 1
  end
end
