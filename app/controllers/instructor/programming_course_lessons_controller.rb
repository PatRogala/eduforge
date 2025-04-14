module Instructor
  # Controller for managing programming course lessons as instructor
  class ProgrammingCourseLessonsController < ApplicationController
    POLICY_CLASS = Instructor::ProgrammingCourseLessonPolicy
    POLICY_SCOPE_CLASS = Instructor::ProgrammingCourseLessonPolicy::Scope

    before_action :authenticate_user!
    before_action :authenticate_instructor!
    before_action :set_lesson

    def edit
      authorize @lesson, policy_class: POLICY_CLASS
    end

    def update
      authorize @lesson, policy_class: POLICY_CLASS

      if @lesson.update(lesson_params)
        redirect_to instructor_programming_course_path(@programming_course), 
                    notice: t('.success')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_lesson
      @chapter = ProgrammingCourseChapter.find(params[:chapter_id])
      @programming_course = @chapter.programming_course
      @lesson = policy_scope(ProgrammingCourseLesson, policy_scope_class: POLICY_SCOPE_CLASS)
                .where(programming_course_chapter_id: @chapter.id)
                .find(params[:id])
    end

    def lesson_params
      params.require(:programming_course_lesson).permit(:title, :content)
    end
  end
end