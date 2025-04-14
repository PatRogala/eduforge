require "rails_helper"

RSpec.describe "Instructor::ProgrammingCourseLessons" do
  let(:user) { create(:user) }
  let(:instructor_role) { create(:role, :instructor) }
  let(:another_instructor) { create(:user) }
  let(:programming_course) { create(:programming_course, instructor: user) }
  let(:chapter) { create(:programming_course_chapter, programming_course: programming_course) }
  let(:lesson) { create(:programming_course_lesson, programming_course_chapter: chapter) }
  let(:another_course) { create(:programming_course, instructor: another_instructor) }
  let(:another_chapter) { create(:programming_course_chapter, programming_course: another_course) }
  let(:another_lesson) { create(:programming_course_lesson, programming_course_chapter: another_chapter) }

  before do
    create(:user_role, user: user, role: instructor_role)
    create(:user_role, user: another_instructor, role: instructor_role)
  end

  describe "GET /instructor/programming_course_chapters/:chapter_id/lessons/:id/edit" do
    context "when user is not authenticated" do
      it "redirects to sign in page" do
        get edit_instructor_programming_course_chapter_lesson_path(programming_course, chapter, lesson)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated as instructor" do
      before do
        sign_in user
      end

      it "returns successful response for own course lesson" do
        get edit_instructor_programming_course_chapter_lesson_path(programming_course, chapter, lesson)
        expect(response).to be_successful
      end

      it "does not allow to access another instructor's course lesson" do
        get edit_instructor_programming_course_chapter_lesson_path(programming_course, another_chapter, another_lesson)
        expect(response).not_to be_successful
      end
    end

    context "when user is not an instructor" do
      let(:regular_user) { create(:user) }

      before do
        sign_in regular_user
      end

      it "forbids unauthorized access" do
        get edit_instructor_programming_course_chapter_lesson_path(programming_course, chapter, lesson)
        expect(response).to be_forbidden
      end
    end
  end

  describe "PATCH /instructor/programming_course_chapters/:chapter_id/lessons/:id" do
    let(:valid_attributes) { { programming_course_lesson: { title: "Updated Title", content: "Updated Content" } } }

    context "when user is not authenticated" do
      it "redirects to sign in page" do
        patch instructor_programming_course_chapter_lesson_path(programming_course, chapter, lesson), params: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated as instructor" do
      before do
        sign_in user
      end

      it "updates the lesson and redirects to course page" do
        patch instructor_programming_course_chapter_lesson_path(programming_course, chapter, lesson), params: valid_attributes
        expect(response).to redirect_to(instructor_programming_course_path(programming_course))
        expect(lesson.reload.title).to eq("Updated Title")
        expect(lesson.reload.content.to_plain_text).to eq("Updated Content")
      end

      it "renders edit template with unprocessable_entity status when update fails" do
        allow_any_instance_of(ProgrammingCourseLesson).to receive(:update).and_return(false)
        patch instructor_programming_course_chapter_lesson_path(programming_course, chapter, lesson), params: valid_attributes
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not allow to update another instructor's course lesson" do
        patch instructor_programming_course_chapter_lesson_path(programming_course, another_chapter, another_lesson), params: valid_attributes
        expect(response).not_to be_successful
      end
    end

    context "when user is not an instructor" do
      let(:regular_user) { create(:user) }

      before do
        sign_in regular_user
      end

      it "forbids unauthorized access" do
        patch instructor_programming_course_chapter_lesson_path(programming_course, chapter, lesson), params: valid_attributes
        expect(response).to be_forbidden
      end
    end
  end
end