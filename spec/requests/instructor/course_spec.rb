require "rails_helper"

RSpec.describe "Instructor::Courses" do
  let(:user) { create(:user) }
  let(:instructor_role) { create(:role, :instructor) }

  before do
    create(:user_role, user: user, role: instructor_role)
  end

  describe "GET /instructor/courses/new" do
    context "when user is not authenticated" do
      it "redirects to sign in page" do
        get new_instructor_course_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated as instructor" do
      before do
        sign_in user
      end

      it "returns successful response" do
        get new_instructor_course_path
        expect(response).to be_successful
      end

      it "renders new template" do
        get new_instructor_course_path
        expect(response).to render_template(:new)
      end
    end

    context "when user is not an instructor" do
      let(:regular_user) { create(:user) }

      before do
        sign_in regular_user
      end

      it "forbids unauthorized access" do
        get new_instructor_course_path
        expect(response).to be_forbidden
      end
    end
  end
end
