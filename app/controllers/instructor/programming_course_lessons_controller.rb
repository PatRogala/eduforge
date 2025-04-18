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
      create_chapter_if_needed
      @lesson = ProgrammingCourseLesson.new(lesson_params)
      authorize @lesson, policy_class: POLICY_CLASS

      if @lesson.save
        redirect_to instructor_programming_course_path(@programming_course),
                    notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize @lesson, policy_class: POLICY_CLASS
      create_chapter_if_needed

      if @lesson.update(lesson_params)
        redirect_to instructor_programming_course_path(@programming_course),
                    notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
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
      params.expect(programming_course_lesson: %i[title content programming_course_chapter_id])
    end

    def create_chapter_if_needed
      return if params[:new_chapter_title]&.strip.blank?

      chapter = @programming_course.programming_course_chapters.create(title: params[:new_chapter_title].strip)
      params[:programming_course_lesson][:programming_course_chapter_id] = chapter.id if chapter.persisted?
      chapter
    end
  end
end
