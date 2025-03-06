module Instructor
  # Allow instructors to create Programming Courses
  class ProgrammingCoursesController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_instructor!

    def index
      @courses = current_user.programming_courses
    end

    def new
      @course = ProgrammingCourse.new
    end

    def create
      @course = ProgrammingCourse.new(course_params)
      @course.instructor = current_user

      if @course.save
        redirect_to instructor_programming_courses_path, notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def course_params
      params.expect(programming_course: [:title])
    end
  end
end
