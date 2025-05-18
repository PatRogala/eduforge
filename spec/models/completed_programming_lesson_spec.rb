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
#  fk_rails_...  (programming_course_lesson_id => programming_course_lessons.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
require "rails_helper"

RSpec.describe CompletedProgrammingLesson do
  let(:user) { create(:user) }
  let(:course) { create(:programming_course, instructor: user) }
  let(:chapter) { create(:programming_course_chapter, programming_course: course) }
  let(:lesson) { create(:programming_course_lesson, programming_course_chapter: chapter) }

  describe "validations" do
    it "validates uniqueness of lesson per user" do
      create(:programming_course_enrollment, user: user, programming_course: course)
      create(:completed_programming_lesson, user: user, programming_course_lesson: lesson)
      duplicate = described_class.new(user: user, programming_course_lesson: lesson)
      duplicate.valid?
      expect(duplicate.errors[:programming_course_lesson]).to include("zostało już zajęte")
    end

    it "is valid if user is enrolled in the course" do
      create(:programming_course_enrollment, user: user, programming_course: course)
      completed = described_class.new(user: user, programming_course_lesson: lesson)
      expect(completed).to be_valid
    end
  end
end
