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
require "rails_helper"

RSpec.describe ProgrammingCourseChapter do
  describe "associations" do
    it { is_expected.to belong_to(:programming_course) }
    it { is_expected.to have_many(:programming_course_lessons).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe "#position" do
    it "returns the position of the first chapter in the course" do
      course = create(:programming_course, instructor: create(:user))
      chapter1 = create(:programming_course_chapter, programming_course: course)
      create(:programming_course_chapter, programming_course: course)

      expect(chapter1.position).to eq(1)
    end

    it "returns the position of the second chapter in the course" do
      course = create(:programming_course, instructor: create(:user))
      create(:programming_course_chapter, programming_course: course)
      chapter2 = create(:programming_course_chapter, programming_course: course)

      expect(chapter2.position).to eq(2)
    end
  end
end
