# Interactor for enrolling a user in a programming course
class EnrollInProgrammingCourse
  include Interactor

  delegate :user, :programming_course, to: :context

  def call
    validate_input
    create_enrollment
  rescue ActiveRecord::RecordInvalid => e
    context.fail!(error: e.message)
  end

  private

  def validate_input
    context.fail!(error: "User is required") unless user
    context.fail!(error: "Programming course is required") unless programming_course
  end

  def create_enrollment
    context.enrollment = ProgrammingCourseEnrollment.create!(
      user: user,
      programming_course: programming_course
    )
  end
end
