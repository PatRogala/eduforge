require "rails_helper"

RSpec.describe Instructor::ProgrammingCoursePolicy, type: :policy do
  subject { described_class }

  let(:instructor) { create(:user) }
  let(:another_instructor) { create(:user) }
  let(:regular_user) { create(:user) }
  let(:instructor_role) { create(:role, :instructor) }
  let(:course) { create(:programming_course, instructor: instructor) }

  before do
    create(:user_role, user: instructor, role: instructor_role)
    create(:user_role, user: another_instructor, role: instructor_role)
  end

  permissions ".scope" do
    let(:scope) { ProgrammingCourse.all }

    context "when user is an instructor" do
      subject { described_class::Scope.new(instructor, scope).resolve }

      it "shows courses created by the instructor" do
        own_course = create(:programming_course, instructor: instructor)

        expect(subject).to include(own_course)
      end

      it "does not show courses created by other instructors" do
        other_course = create(:programming_course, instructor: another_instructor)
        expect(subject).not_to include(other_course)
      end
    end
  end

  permissions :show?, :update? do
    it "denies access if user is not an instructor" do
      expect(subject).not_to permit(regular_user, course)
    end

    it "allows access if user is an instructor" do
      expect(subject).to permit(instructor, course)
    end
  end

  permissions :create? do
    it "denies access if user is not an instructor" do
      expect(subject).not_to permit(regular_user, ProgrammingCourse)
    end

    it "allows access if user is an instructor" do
      expect(subject).to permit(instructor, ProgrammingCourse)
    end
  end
end
