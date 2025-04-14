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
  let(:lesson_attributes) do
    attributes_for(:programming_course_lesson).merge(programming_course_chapter_id: chapter.id)
  end
  let(:invalid_attributes) { { programming_course_lesson: { title: nil } } }

  before do
    create(:user_role, user: user, role: instructor_role)
    create(:user_role, user: another_instructor, role: instructor_role)
  end

  describe "GET /instructor/programming_courses/:programming_course_id/lessons/new" do
    context "when user is not authenticated" do
      it "redirects to sign in page" do
        get new_instructor_programming_course_lesson_path(programming_course)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated as instructor" do
      before do
        sign_in user
      end

      it "returns successful response" do
        get new_instructor_programming_course_lesson_path(programming_course)
        expect(response).to be_successful
      end

      it "renders new template" do
        get new_instructor_programming_course_lesson_path(programming_course)
        expect(response).to render_template(:new)
      end
    end

    context "when user is not an instructor" do
      let(:regular_user) { create(:user) }

      before do
        sign_in regular_user
      end

      it "forbids unauthorized access" do
        get new_instructor_programming_course_lesson_path(programming_course)
        expect(response).to be_forbidden
      end
    end
  end

  describe "POST /instructor/programming_courses/:programming_course_id/lessons" do
    context "when user is not authenticated" do
      it "redirects to sign in page" do
        post instructor_programming_course_lessons_path(programming_course),
             params: { programming_course_lesson: lesson_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated as instructor" do
      before do
        sign_in user
      end

      it "creates a new lesson" do
        expect do
          post instructor_programming_course_lessons_path(programming_course),
               params: { programming_course_lesson: lesson_attributes }
        end.to change(ProgrammingCourseLesson, :count).by(1)
      end

      it "redirects to the programming course page" do
        post instructor_programming_course_lessons_path(programming_course),
             params: { programming_course_lesson: lesson_attributes }
        expect(response).to redirect_to(instructor_programming_course_path(programming_course))
      end

      context "with invalid parameters" do
        let(:invalid_attributes) { { title: "" } }

        it "does not create a new lesson" do
          expect do
            post instructor_programming_course_lessons_path(programming_course),
                 params: { programming_course_lesson: invalid_attributes }
          end.not_to change(ProgrammingCourseLesson, :count)
        end

        it "renders the new template" do
          post instructor_programming_course_lessons_path(programming_course),
               params: { programming_course_lesson: invalid_attributes }
          expect(response).to render_template(:new)
        end

        it "return unprocessable entity status" do
          post instructor_programming_course_lessons_path(programming_course),
               params: { programming_course_lesson: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "when user is not an instructor" do
      let(:regular_user) { create(:user) }

      before do
        sign_in regular_user
      end

      it "forbids unauthorized access" do
        post instructor_programming_course_lessons_path(programming_course),
             params: { programming_course_lesson: lesson_attributes }
        expect(response).to be_forbidden
      end
    end
  end

  describe "GET /instructor/lessons/:id/edit" do
    context "when user is not authenticated" do
      it "redirects to sign in page" do
        get edit_instructor_programming_course_lesson_path(programming_course, lesson)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated as instructor" do
      before do
        sign_in user
      end

      it "returns successful response for own course lesson" do
        get edit_instructor_programming_course_lesson_path(programming_course, lesson)
        expect(response).to be_successful
      end

      it "does not allow to access another instructor's course lesson" do
        get edit_instructor_programming_course_lesson_path(programming_course, another_chapter, another_lesson)
        expect(response).not_to be_successful
      end
    end

    context "when user is not an instructor" do
      let(:regular_user) { create(:user) }

      before do
        sign_in regular_user
      end

      it "forbids unauthorized access" do
        get edit_instructor_programming_course_lesson_path(programming_course, lesson)
        expect(response).to be_forbidden
      end
    end
  end

  describe "PATCH /instructor/lessons/:id" do
    let(:valid_attributes) { { programming_course_lesson: { title: "Updated Title", content: "Updated Content" } } }

    context "when user is not authenticated" do
      it "redirects to sign in page" do
        patch instructor_programming_course_lesson_path(programming_course, lesson), params: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated as instructor" do
      before do
        sign_in user
      end

      it "updates the lesson title" do
        patch instructor_programming_course_lesson_path(programming_course, lesson), params: valid_attributes
        expect(lesson.reload.title).to eq("Updated Title")
      end

      it "updates the lesson content" do
        patch instructor_programming_course_lesson_path(programming_course, lesson), params: valid_attributes
        expect(lesson.reload.content.to_plain_text).to eq("Updated Content")
      end

      it "redirects to course page" do
        patch instructor_programming_course_lesson_path(programming_course, lesson), params: valid_attributes
        expect(response).to redirect_to(instructor_programming_course_path(programming_course))
      end

      it "renders edit template when update fails" do
        patch instructor_programming_course_lesson_path(programming_course, lesson), params: invalid_attributes
        expect(response).to render_template(:edit)
      end

      it "returns unprocessable_entity status when update fails" do
        patch instructor_programming_course_lesson_path(programming_course, lesson), params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not allow to update another instructor's course lesson" do
        patch instructor_programming_course_lesson_path(programming_course, another_chapter, another_lesson),
              params: valid_attributes
        expect(response).not_to be_successful
      end
    end

    context "when user is not an instructor" do
      let(:regular_user) { create(:user) }

      before do
        sign_in regular_user
      end

      it "forbids unauthorized access" do
        patch instructor_programming_course_lesson_path(programming_course, lesson), params: valid_attributes
        expect(response).to be_forbidden
      end
    end
  end
end
