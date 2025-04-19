# Programming course allow to create programming assignments
# == Schema Information
#
# Table name: programming_courses
#
#  id            :bigint           not null, primary key
#  slug          :string
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instructor_id :bigint           not null
#
# Indexes
#
#  index_programming_courses_on_instructor_id  (instructor_id)
#  index_programming_courses_on_slug           (slug) UNIQUE
#  index_programming_courses_on_title          (title) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (instructor_id => users.id) ON DELETE => cascade
#
class ProgrammingCourse < ApplicationRecord
  extend FriendlyId

  belongs_to :instructor, class_name: "User"
  has_rich_text :description
  has_one_attached :cover_image
  has_many :programming_course_chapters, dependent: :destroy
  has_many :programming_course_lessons, through: :programming_course_chapters
  has_many :programming_course_enrollments, dependent: :delete_all
  has_many :enrolled_users, through: :programming_course_enrollments, source: :user

  validates :title, presence: true, uniqueness: true
  validates :slug, uniqueness: true, allow_blank: true

  friendly_id :title, use: :slugged

  def created_time_ago
    days = (Time.current - created_at).to_i / 1.day
    "Stworzono #{days} dni temu"
  end

  def should_generate_new_friendly_id?
    title_changed? || slug.blank?
  end

  def approximate_duration_in_minutes
    programming_course_lessons.with_rich_text_content_and_embeds.inject(0) do |sum, lesson|
      sum + lesson.approximate_duration_in_minutes
    end
  end

  def approximate_duration_in_hours
    Rails.cache.fetch("programming_course_#{id}_approximate_duration_in_hours", expires_in: 1.day) do
      (approximate_duration_in_minutes / 60.0).round(1)
    end
  end
end
