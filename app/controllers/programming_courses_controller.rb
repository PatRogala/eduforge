# Generic routes for programming courses to show them to any user
class ProgrammingCoursesController < ApplicationController
  def show
    @course = ProgrammingCourse.friendly.find(params[:id])
  end
end
