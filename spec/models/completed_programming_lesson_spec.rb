require "rails_helper"

RSpec.describe CompletedProgrammingLesson, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:course) { FactoryBot.create(:programming_course, instructor: user) }
  let(:chapter) { FactoryBot.create(:programming_course_chapter, programming_course: course) }
  let(:lesson) { FactoryBot.create(:programming_course_lesson, programming_course_chapter: chapter) }

  context "validations" do
    it "validates uniqueness of lesson per user" do
      FactoryBot.create(:programming_course_enrollment, user: user, programming_course: course)
      FactoryBot.create(:completed_programming_lesson, user: user, programming_course_lesson: lesson)
      duplicate = CompletedProgrammingLesson.new(user: user, programming_course_lesson: lesson)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:programming_course_lesson]).to include("zostało już zajęte")
    end

    it "is valid if user is enrolled in the course" do
      FactoryBot.create(:programming_course_enrollment, user: user, programming_course: course)
      completed = CompletedProgrammingLesson.new(user: user, programming_course_lesson: lesson)
      expect(completed).to be_valid
    end

    it "is invalid if user is not enrolled in the course" do
      completed = CompletedProgrammingLesson.new(user: user, programming_course_lesson: lesson)
      expect(completed).not_to be_valid
      expect(completed.errors[:base]).to include("User is not enrolled in the course")
    end
  end
end
