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
require "rails_helper"

RSpec.describe ProgrammingCourse do
  pending "add some examples to (or delete) #{__FILE__}"
end
