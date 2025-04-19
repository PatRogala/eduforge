# Generic routes for programming courses to show them to any user
class ProgrammingCoursesController < ApplicationController
  before_action :authenticate_user!, only: %i[my_courses]

  def show
    @course = ProgrammingCourse.friendly.find(params[:id])
  end

  def my_courses
    @courses = current_user.enrolled_programming_courses
                           .with_rich_text_description
                           .includes(:instructor, :cover_image_attachment)
                           .order(created_at: :desc)
  end
end
