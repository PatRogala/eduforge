# Generic routes for courses to show them to any user
class CoursesController < ApplicationController
  def index
    @courses = ProgrammingCourse.with_rich_text_description.all
  end

  def show
    @course = ProgrammingCourse.find(params[:id])
  end
end
