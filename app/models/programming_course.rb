# Programming course allow to create programming assignments
# == Schema Information
#
# Table name: programming_courses
#
#  id            :bigint           not null, primary key
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instructor_id :bigint           not null
#
# Indexes
#
#  index_programming_courses_on_instructor_id  (instructor_id)
#  index_programming_courses_on_title          (title) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (instructor_id => users.id) ON DELETE => cascade
#
class ProgrammingCourse < ApplicationRecord
  belongs_to :instructor, class_name: "User"

  validates :title, presence: true, uniqueness: true

  def created_time_ago
    days = (Time.current - created_at).to_i / 1.day
    "Stworzono #{days} dni temu"
  end
end
