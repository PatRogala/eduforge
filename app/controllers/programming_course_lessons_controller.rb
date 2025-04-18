class ProgrammingCourseLessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson

  def show
    authorize @lesson
  end

  private

  def set_lesson
    @lesson = ProgrammingCourseLesson.find(params[:id])
  end
end
