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
      authorize @lesson, policy_class: POLICY_CLASS
    end

    def edit
      authorize @lesson, policy_class: POLICY_CLASS
    end

    def create
      transaction do
        create_chapter_if_needed
        @lesson = ProgrammingCourseLesson.new(lesson_params)
        authorize @lesson, policy_class: POLICY_CLASS

        if @lesson.save
          create_programming_task if params[:has_programming_task] == "1"
          redirect_to instructor_programming_course_path(@programming_course),
                      notice: t(".success")
        else
          render :new, status: :unprocessable_entity
        end
      end
    end

    def update
      transaction do
        authorize @lesson, policy_class: POLICY_CLASS
        create_chapter_if_needed

        if @lesson.update(lesson_params)
          handle_programming_task
          redirect_to instructor_programming_course_path(@programming_course),
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
      params.require(:programming_course_lesson).permit(:title, :content, :programming_course_chapter_id)
    end

    def create_chapter_if_needed
      return if params[:new_chapter_title]&.strip.blank?

      chapter = @programming_course.programming_course_chapters.create(title: params[:new_chapter_title].strip)
      params[:programming_course_lesson][:programming_course_chapter_id] = chapter.id if chapter.persisted?
      chapter
    end

    def create_programming_task
      task_params = params.require(:programming_task).permit(
        :initial_code, :solution_code, :test_cases, :difficulty_level, :points, hints: []
      )
      @lesson.create_programming_task(task_params)
    end

    def handle_programming_task
      if params[:has_programming_task] == "1"
        if @lesson.programming_task
          update_programming_task
        else
          create_programming_task
        end
      elsif @lesson.programming_task
        @lesson.programming_task.destroy
      end
    end

    def update_programming_task
      task_params = params.require(:programming_task).permit(
        :initial_code, :solution_code, :test_cases, :difficulty, :hints
      )
      @lesson.programming_task.update(task_params)
    end
  end
end
