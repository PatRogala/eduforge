require "rails_helper"

RSpec.describe "CompletedProgrammingLessons" do
  let(:user) { create(:user) }
  let(:course) { create(:programming_course, instructor: user) }
  let(:chapter) { create(:programming_course_chapter, programming_course: course) }
  let(:lesson) { create(:programming_course_lesson, programming_course_chapter: chapter) }
  let(:valid_params) { { completed_programming_lesson: { programming_course_lesson_id: lesson.id, user_id: user.id } } }

  before do
    sign_in user
  end

  describe "POST /create" do
    it "creates a new completed programming lesson" do
      create(:programming_course_enrollment, user: user, programming_course: course)
      expect do
        post completed_programming_lessons_path(valid_params)
      end.to change(CompletedProgrammingLesson, :count).by(1)
    end

    it "does not create a new completed programming lesson if the user is not enrolled in the course" do
      expect do
        post completed_programming_lessons_path(valid_params)
      end.to raise_error(Pundit::NotAuthorizedError)
    end
  end
end
