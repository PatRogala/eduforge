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
end
