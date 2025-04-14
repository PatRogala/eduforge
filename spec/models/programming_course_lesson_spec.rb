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
require "rails_helper"

RSpec.describe ProgrammingCourseLesson do
  describe "associations" do
    it { is_expected.to belong_to(:programming_course_chapter) }
    it { is_expected.to have_rich_text(:content) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe "#programming_course" do
    it "returns the course the lesson belongs to" do
      course = create(:programming_course, instructor: create(:user))
      chapter = create(:programming_course_chapter, programming_course: course)
      lesson = create(:programming_course_lesson, programming_course_chapter: chapter)

      expect(lesson.programming_course).to eq(course)
    end
  end

  describe "#position" do
    it "returns the position of the first lesson in the chapter" do
      course = create(:programming_course, instructor: create(:user))
      chapter = create(:programming_course_chapter, programming_course: course)
      lesson1 = create(:programming_course_lesson, programming_course_chapter: chapter)
      create(:programming_course_lesson, programming_course_chapter: chapter)

      expect(lesson1.position).to eq(1)
    end

    it "returns the position of the second lesson in the chapter" do
      course = create(:programming_course, instructor: create(:user))
      chapter = create(:programming_course_chapter, programming_course: course)
      create(:programming_course_lesson, programming_course_chapter: chapter)
      lesson2 = create(:programming_course_lesson, programming_course_chapter: chapter)

      expect(lesson2.position).to eq(2)
    end
  end
end
