require "rails_helper"

RSpec.describe "ProgrammingCourseEnrollments" do
  let(:user) { create(:user) }
  let(:course) { create(:programming_course, instructor: create(:user)) }

  describe "POST /programming_course_enrollments" do
    context "when user is not authenticated" do
      it "redirects to sign in page" do
        post programming_course_enrollments_path(id: course.slug)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated" do
      before do
        sign_in user
      end

      it "creates a new enrollment" do
        expect do
          post programming_course_enrollments_path(id: course.slug)
        end.to change(ProgrammingCourseEnrollment, :count).by(1)
      end

      it "redirects to the course page" do
        post programming_course_enrollments_path(id: course.slug)
        expect(response).to redirect_to(programming_course_path(course))
      end

      it "sets up a success message" do
        post programming_course_enrollments_path(id: course.slug)
        expect(flash[:notice]).to eq("Zapisano Cię na ten kurs")
      end

      context "when user is already enrolled" do
        before do
          create(:programming_course_enrollment, user: user, programming_course: course)
        end

        it "does not create another enrollment" do
          expect do
            post programming_course_enrollments_path(id: course.slug)
          end.not_to change(ProgrammingCourseEnrollment, :count)
        end

        it "redirects to the course page" do
          post programming_course_enrollments_path(id: course.slug)
          expect(response).to redirect_to(programming_course_path(course))
        end

        it "sets up an error message" do
          post programming_course_enrollments_path(id: course.slug)
          expect(flash[:alert]).to include("Jesteś już zapisany na ten kurs")
        end
      end
    end
  end
end
