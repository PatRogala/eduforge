module Instructor
  # Controller for managing programming course lessons as instructor
  class ProgrammingCourseLessonsController < ApplicationController
    POLICY_CLASS = Instructor::ProgrammingCourseLessonPolicy
    POLICY_SCOPE_CLASS = Instructor::ProgrammingCourseLessonPolicy::Scope

    before_action :authenticate_user!
    before_action :authenticate_instructor!
    before_action :set_programming_course
    before_action :set_lesson, only: %i[edit update]
    before_action :set_chapter, only: %i[edit update]

    def new
      @lesson = ProgrammingCourseLesson.new
      @lesson.build_programming_task unless @lesson.programming_task
      authorize @lesson, policy_class: POLICY_CLASS
    end

    def edit
      @lesson.build_programming_task unless @lesson.programming_task
      authorize @lesson, policy_class: POLICY_CLASS
    end

    def create
      ActiveRecord::Base.transaction do
        create_chapter_if_needed
        @lesson = ProgrammingCourseLesson.new(lesson_params)
        authorize @lesson, policy_class: POLICY_CLASS

        handle_task_destruction_on_create

        if @lesson.save
          redirect_to edit_instructor_programming_course_lesson_path(@programming_course, @lesson),
                      notice: t(".success")
        else
          @lesson.build_programming_task if params.dig(:programming_course_lesson,
                                                       :has_programming_task) == "1" && @lesson.programming_task.nil?
          render :new, status: :unprocessable_entity
        end
      end
    end

    def update
      ActiveRecord::Base.transaction do
        authorize @lesson, policy_class: POLICY_CLASS
        create_chapter_if_needed

        lesson_attributes = lesson_params

        handle_task_destruction_on_update(lesson_attributes)

        if @lesson.update(lesson_attributes)
          redirect_to edit_instructor_programming_course_lesson_path(@programming_course, @lesson),
                      notice: t(".success")
        else
          render :edit, status: :unprocessable_entity
        end
      end
    end

    private

    def set_programming_course
      @programming_course = ProgrammingCourse.friendly.find(params[:programming_course_id])
    end

    def set_chapter
      @chapter = @lesson.programming_course_chapter
    end

    def set_lesson
      @lesson = policy_scope(ProgrammingCourseLesson, policy_scope_class: POLICY_SCOPE_CLASS)
                .find(params[:id])
    end

    def lesson_params
      params.require(:programming_course_lesson).permit(:title, :content, :programming_course_chapter_id,
                                                        programming_task_attributes: %i[id initial_code solution_code test_cases difficulty hints _destroy])
    end

    def create_chapter_if_needed
      return if params[:new_chapter_title]&.strip.blank?

      chapter = @programming_course.programming_course_chapters.create(title: params[:new_chapter_title].strip)
      params[:programming_course_lesson][:programming_course_chapter_id] = chapter.id if chapter.persisted?
      chapter
    end

    def handle_task_destruction_on_create
      # If the checkbox is "0" (unchecked), ensure no task attributes are processed
      return unless params.dig(:programming_course_lesson, :has_programming_task) == "0"

      # Remove the nested attributes hash entirely so reject_if works reliably
      # and no attempt is made to create/update the task.
      lesson_params.delete(:programming_task_attributes)
    end

    def handle_task_destruction_on_update(attrs)
      # If checkbox is unchecked ("0") and a task exists, mark it for destruction
      if params.dig(:programming_course_lesson, :has_programming_task) == "0" && @lesson.programming_task.present?
        # Add _destroy: '1' to the nested attributes hash
        attrs[:programming_task_attributes] ||= {} # Ensure hash exists
        attrs[:programming_task_attributes][:id] = @lesson.programming_task.id # Ensure ID is present for destruction
        attrs[:programming_task_attributes][:_destroy] = "1"
      elsif params.dig(:programming_course_lesson, :has_programming_task) == "1" && attrs[:programming_task_attributes]
        # If checkbox is checked, ensure _destroy is not set or is false
        attrs[:programming_task_attributes].delete(:_destroy)
      elsif params.dig(:programming_course_lesson, :has_programming_task) == "0"
        # If checkbox is unchecked and no task exists, ensure no attributes are sent
        attrs.delete(:programming_task_attributes)
      end
    end
  end
end
