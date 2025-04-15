# Enrolling user in a programming course
class ProgrammingCourseEnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_programming_course

  def create
    result = EnrollInProgrammingCourse.call(
      user: current_user,
      programming_course: @programming_course
    )

    if result.success?
      redirect_to programming_course_path(@programming_course),
                  notice: t(".success")
    else
      redirect_to programming_course_path(@programming_course),
                  alert: result.error
    end
  end

  private

  def set_programming_course
    @programming_course = ProgrammingCourse.friendly.find(params[:id])
  end
end
