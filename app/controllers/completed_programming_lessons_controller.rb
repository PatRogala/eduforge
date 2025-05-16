# Tracks user completion of programming lessons
class CompletedProgrammingLessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_programming_course_lesson

  def create
    @completed_programming_lesson = CompletedProgrammingLesson.new(completed_programming_lesson_params)
    authorize @completed_programming_lesson

    if @completed_programming_lesson.save
      redirect_to @programming_course_lesson, notice: t(".success")
    else
      redirect_to @programming_course_lesson, alert: t(".error")
    end
  end

  private

  def set_programming_course_lesson
    @programming_course_lesson = ProgrammingCourseLesson.find(completed_programming_lesson_params[:programming_course_lesson_id])
  end

  def completed_programming_lesson_params
    params.expect(completed_programming_lesson: %i[user_id programming_course_lesson_id])
  end
end
