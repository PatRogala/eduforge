require "rails_helper"

RSpec.describe "Instructor::ProgrammingCourses" do
  let(:user) { create(:user) }
  let(:instructor_role) { create(:role, :instructor) }
  let(:another_instructor) { create(:user) }
  let(:programming_course) { create(:programming_course, instructor: user) }
  let(:another_course) { create(:programming_course, instructor: another_instructor) }

  before do
    create(:user_role, user: user, role: instructor_role)
    create(:user_role, user: another_instructor, role: instructor_role)
  end

  describe "GET /instructor/programming_courses" do
    context "when user is not authenticated" do
      it "redirects to sign in page" do
        get instructor_programming_courses_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated as instructor" do
      before do
        sign_in user
        programming_course # Create the course
        another_course # Create another instructor's course
      end

      it "returns successful response" do
        get instructor_programming_courses_path
        expect(response).to be_successful
      end

      it "displays all courses created by current user" do
        get instructor_programming_courses_path
        expect(assigns(:courses)).to include(programming_course)
      end
    end

    context "when user is not an instructor" do
      let(:regular_user) { create(:user) }

      before do
        sign_in regular_user
      end

      it "forbids unauthorized access" do
        get instructor_programming_courses_path
        expect(response).to be_forbidden
      end
    end
  end

  describe "GET /instructor/programming_courses/:id" do
    context "when user is not authenticated" do
      it "redirects to sign in page" do
        get instructor_programming_course_path(programming_course)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated as instructor" do
      before do
        sign_in user
      end

      it "returns successful response for own course" do
        get instructor_programming_course_path(programming_course)
        expect(response).to be_successful
      end

      it "does not allow to access another instructor's course" do
        get instructor_programming_course_path(another_course)
        expect(response).not_to be_successful
      end
    end

    context "when user is not an instructor" do
      let(:regular_user) { create(:user) }

      before do
        sign_in regular_user
      end

      it "forbids unauthorized access" do
        get instructor_programming_course_path(programming_course)
        expect(response).to be_forbidden
      end
    end
  end

  describe "GET /instructor/programming_courses/new" do
    context "when user is not authenticated" do
      it "redirects to sign in page" do
        get new_instructor_programming_course_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated as instructor" do
      before do
        sign_in user
      end

      it "returns successful response" do
        get new_instructor_programming_course_path
        expect(response).to be_successful
      end

      it "renders new template" do
        get new_instructor_programming_course_path
        expect(response).to render_template(:new)
      end
    end

    context "when user is not an instructor" do
      let(:regular_user) { create(:user) }

      before do
        sign_in regular_user
      end

      it "forbids unauthorized access" do
        get new_instructor_programming_course_path
        expect(response).to be_forbidden
      end
    end
  end

  describe "GET /instructor/programming_courses/:id/edit" do
    context "when user is not authenticated" do
      it "redirects to sign in page" do
        get edit_instructor_programming_course_path(programming_course)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated as instructor" do
      before do
        sign_in user
      end

      it "returns successful response for own course" do
        get edit_instructor_programming_course_path(programming_course)
        expect(response).to be_successful
      end

      it "renders edit template" do
        get edit_instructor_programming_course_path(programming_course)
        expect(response).to render_template(:edit)
      end

      it "does not allow access to another instructor's course" do
        get edit_instructor_programming_course_path(another_course)
        expect(response).not_to be_successful
      end
    end

    context "when user is not an instructor" do
      let(:regular_user) { create(:user) }

      before do
        sign_in regular_user
      end

      it "forbids unauthorized access" do
        get edit_instructor_programming_course_path(programming_course)
        expect(response).to be_forbidden
      end
    end
  end

  describe "POST /instructor/programming_courses" do
    let(:valid_attributes) { { programming_course: { title: "New Programming Course" } } }
    let(:invalid_attributes) { { programming_course: { title: "" } } }

    context "when user is not authenticated" do
      it "redirects to sign in page" do
        post instructor_programming_courses_path, params: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated as instructor" do
      before do
        sign_in user
      end

      it "creates a new programming course with valid attributes" do
        expect do
          post instructor_programming_courses_path, params: valid_attributes
        end.to change(ProgrammingCourse, :count).by(1)
      end

      it "redirects to the courses index with valid attributes" do
        post instructor_programming_courses_path, params: valid_attributes
        expect(response).to redirect_to(instructor_programming_courses_path)
      end

      it "sets the current user as the instructor" do
        post instructor_programming_courses_path, params: valid_attributes
        expect(ProgrammingCourse.last.instructor).to eq(user)
      end

      it "does not create a course with invalid attributes" do
        expect do
          post instructor_programming_courses_path, params: invalid_attributes
        end.not_to change(ProgrammingCourse, :count)
      end

      it "renders new template with invalid attributes" do
        post instructor_programming_courses_path, params: invalid_attributes
        expect(response).to render_template(:new)
      end
    end

    context "when user is not an instructor" do
      let(:regular_user) { create(:user) }

      before do
        sign_in regular_user
      end

      it "forbids unauthorized access" do
        post instructor_programming_courses_path, params: valid_attributes
        expect(response).to be_forbidden
      end
    end
  end

  describe "PATCH /instructor/programming_courses/:id" do
    let(:valid_attributes) { { programming_course: { title: "Updated Programming Course" } } }
    let(:invalid_attributes) { { programming_course: { title: "" } } }

    context "when user is not authenticated" do
      it "redirects to sign in page" do
        patch instructor_programming_course_path(programming_course), params: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated as instructor" do
      before do
        sign_in user
      end

      it "updates the course with valid attributes" do
        patch instructor_programming_course_path(programming_course), params: valid_attributes
        programming_course.reload
        expect(programming_course.title).to eq("Updated Programming Course")
      end

      it "redirects to the course show page with valid attributes" do
        patch instructor_programming_course_path(programming_course), params: valid_attributes
        expect(response).to redirect_to(instructor_programming_course_path(programming_course))
      end

      it "does not update the course with invalid attributes" do
        original_title = programming_course.title
        patch instructor_programming_course_path(programming_course), params: invalid_attributes
        programming_course.reload
        expect(programming_course.title).to eq(original_title)
      end

      it "renders edit template with invalid attributes" do
        patch instructor_programming_course_path(programming_course), params: invalid_attributes
        expect(response).to render_template(:edit)
      end

      it "does not allow updating another instructor's course" do
        patch instructor_programming_course_path(another_course), params: valid_attributes
        expect(response).not_to redirect_to(instructor_programming_course_path(another_course))
      end
    end

    context "when user is not an instructor" do
      let(:regular_user) { create(:user) }

      before do
        sign_in regular_user
      end

      it "forbids unauthorized access" do
        patch instructor_programming_course_path(programming_course), params: valid_attributes
        expect(response).to be_forbidden
      end
    end
  end
end
