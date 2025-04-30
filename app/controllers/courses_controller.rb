# Generic routes for courses to show them to any user
class CoursesController < ApplicationController
  before_action :authenticate_user!, only: %i[my]

  def index
    @courses = ProgrammingCourse.with_rich_text_description.all
  end

  def my
    @courses = current_user.enrolled_programming_courses
                           .with_rich_text_description
                           .includes(:instructor, :cover_image_attachment)
                           .order(created_at: :desc)
  end
end
