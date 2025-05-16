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
      expect(duplicate.errors[:programming_course_lesson]).to include("zostało już zajęte")
    end

    it "is valid if user is enrolled in the course" do
      create(:programming_course_enrollment, user: user, programming_course: course)
      completed = described_class.new(user: user, programming_course_lesson: lesson)
      expect(completed).to be_valid
    end

    it "is invalid if user is not enrolled in the course" do
      completed = described_class.new(user: user, programming_course_lesson: lesson)
      expect(completed.errors[:base]).to include("User is not enrolled in the course")
    end
  end
end
