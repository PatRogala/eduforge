# app/controllers/instructor/programming_course_lessons_controller.rb
module Instructor
  # Controller for managing programming course lessons as instructor
  class ProgrammingCourseLessonsController < ApplicationController
    POLICY_CLASS = Instructor::ProgrammingCourseLessonPolicy
    POLICY_SCOPE_CLASS = Instructor::ProgrammingCourseLessonPolicy::Scope

    before_action :authenticate_user!
    before_action :authenticate_instructor!
    before_action :set_programming_course
    before_action :set_lesson, only: %i[edit update]

    def new
      # Initialize the form object for a new lesson
      @form = LessonForm.new({}, programming_course: @programming_course, instructor: current_user)
      # Authorize the underlying new lesson object within the form
      authorize @form.lesson, policy_class: POLICY_CLASS
    end

    def edit
      # Initialize the form object with the existing lesson
      # Pass existing attributes from lesson to form for initial population (handled internally by LessonForm now)
      @form = LessonForm.new({}, programming_course: @programming_course, instructor: current_user, lesson: @lesson)
      # Authorization happens inside the form's submit method now for update, but check edit access here
      authorize @form.lesson, policy_class: POLICY_CLASS
    end

    def create
      @form = LessonForm.new(lesson_form_params, programming_course: @programming_course, instructor: current_user)
      authorize @form.lesson, policy_class: POLICY_CLASS

      if @form.submit
        redirect_to edit_instructor_programming_course_lesson_path(@programming_course, @form.lesson),
                    notice: t(".success")
      else
        flash.now[:alert] = @form.errors.full_messages.join(", ")
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @form = LessonForm.new(lesson_form_params, programming_course: @programming_course, instructor: current_user, lesson: @lesson)
      authorize @form.lesson, policy_class: POLICY_CLASS

      if @form.submit
        redirect_to edit_instructor_programming_course_lesson_path(@programming_course, @form.lesson),
                    notice: t(".success")
      else
        flash.now[:alert] = @form.errors.full_messages.join(", ")
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_programming_course
      @programming_course = policy_scope(ProgrammingCourse,
                                         policy_scope_class: Instructor::ProgrammingCoursePolicy::Scope)
                            .friendly.find(params[:programming_course_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to instructor_programming_courses_path, alert: "Course not found or not authorized."
    end

    def set_lesson
      @lesson = policy_scope(ProgrammingCourseLesson, policy_scope_class: POLICY_SCOPE_CLASS)
                .where(programming_course_chapter_id: @programming_course.programming_course_chapter_ids)
                .find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to instructor_programming_course_path(@programming_course), alert: "Lesson not found or not authorized."
    end

    # Strong parameters for the Form Object
    def lesson_form_params
      params.require(:instructor_lesson_form).permit(
        :title,
        :content,
        :programming_course_chapter_id,
        :new_chapter_title,
        :has_programming_task,
        programming_task_attributes: %i[id initial_code solution_code test_cases difficulty hints _destroy]
      )
    end
  end
end
