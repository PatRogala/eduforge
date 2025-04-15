require "rails_helper"

RSpec.describe EnrollInProgrammingCourse do
  let(:user) { create(:user) }
  let(:course) { create(:programming_course, instructor: create(:user)) }

  describe ".call" do
    context "with valid input" do
      it "is successful" do
        result = described_class.call(user: user, programming_course: course)

        expect(result).to be_success
      end

      it "creates an enrollment" do
        result = described_class.call(user: user, programming_course: course)

        expect(result.enrollment).to be_persisted
      end

      it "creates an enrollment with the correct user" do
        result = described_class.call(user: user, programming_course: course)

        expect(result.enrollment.user).to eq(user)
      end

      it "creates an enrollment with the correct course" do
        result = described_class.call(user: user, programming_course: course)

        expect(result.enrollment.programming_course).to eq(course)
      end
    end

    context "with missing user" do
      it "fails with an error" do
        result = described_class.call(programming_course: course)

        expect(result.error).to eq("User is required")
      end
    end

    context "with missing course" do
      it "fails with an error" do
        result = described_class.call(user: user)

        expect(result.error).to eq("Programming course is required")
      end
    end

    context "when user is already enrolled" do
      before do
        create(:programming_course_enrollment, user: user, programming_course: course)
      end

      it "fails with validation error" do
        result = described_class.call(user: user, programming_course: course)

        expect(result.error).to include("Jesteś już zapisany na ten kurs")
      end
    end
  end
end
