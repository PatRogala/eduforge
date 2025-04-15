# == Schema Information
#
# Table name: programming_course_enrollments
#
#  id                    :bigint           not null, primary key
#  enrolled_at           :datetime         not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  programming_course_id :bigint           not null
#  user_id               :bigint           not null
#
# Indexes
#
#  idx_on_user_id_programming_course_id_dcb9194487                (user_id,programming_course_id) UNIQUE
#  index_programming_course_enrollments_on_programming_course_id  (programming_course_id)
#  index_programming_course_enrollments_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (programming_course_id => programming_courses.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
require "rails_helper"

RSpec.describe ProgrammingCourseEnrollment do
  let(:user) { create(:user) }
  let(:course) { create(:programming_course, instructor: create(:user)) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:programming_course) }
  end

  describe "validations" do
    it "allows a user to enroll in a course" do
      enrollment = build(:programming_course_enrollment, user: user, programming_course: course)
      expect(enrollment).to be_valid
    end

    it "prevents duplicate enrollments" do
      create(:programming_course_enrollment, user: user, programming_course: course)
      duplicate_enrollment = build(:programming_course_enrollment, user: user, programming_course: course)
      duplicate_enrollment.valid?
      expect(duplicate_enrollment.errors[:user_id]).to include("Jesteś już zapisany na ten kurs")
    end
  end

  describe "enrolled_at" do
    it "sets enrolled_at to current time by default" do
      enrollment = create(:programming_course_enrollment, user: user, programming_course: course)
      expect(enrollment.enrolled_at).to be_within(1.second).of(Time.current)
    end
  end
end
