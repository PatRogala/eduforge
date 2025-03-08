module Instructor
  # Allow instructors to create Programming Courses
  class ProgrammingCoursesController < ApplicationController
    POLICY_CLASS = Instructor::ProgrammingCoursePolicy
    POLICY_SCOPE_CLASS = Instructor::ProgrammingCoursePolicy::Scope

    before_action :authenticate_user!
    before_action :authenticate_instructor!

    def index
      @courses = policy_scope(ProgrammingCourse, policy_scope_class: POLICY_SCOPE_CLASS)
      authorize @courses, policy_class: POLICY_CLASS
    end

    def show
      @course = policy_scope(ProgrammingCourse, policy_scope_class: POLICY_SCOPE_CLASS).find(params[:id])
      authorize @course, policy_class: POLICY_CLASS
    end

    def new
      @course = ProgrammingCourse.new
      authorize @course, policy_class: POLICY_CLASS
    end

    def edit
      @course = policy_scope(ProgrammingCourse, policy_scope_class: POLICY_SCOPE_CLASS).find(params[:id])
      authorize @course, policy_class: POLICY_CLASS
    end

    def create
      @course = ProgrammingCourse.new(course_params)
      @course.instructor = current_user
      authorize @course, policy_class: POLICY_CLASS

      if @course.save
        redirect_to instructor_programming_courses_path, notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @course = policy_scope(ProgrammingCourse, policy_scope_class: POLICY_SCOPE_CLASS).find(params[:id])
      authorize @course, policy_class: POLICY_CLASS

      if @course.update(course_params)
        redirect_to instructor_programming_course_path(@course), notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def course_params
      params.expect(programming_course: [:title, :description])
    end
  end
end
