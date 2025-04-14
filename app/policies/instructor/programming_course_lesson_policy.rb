module Instructor
  # Policy for Programming Course Lessons
  class ProgrammingCourseLessonPolicy < ApplicationPolicy
    # Scope for Programming Course Lessons
    class Scope < Scope
      def resolve
        scope.joins(programming_course_chapter: { programming_course: :instructor })
              .where(programming_course_chapters: { programming_courses: { instructor: user } })
      end
    end

    def new?
      user.instructor?
    end

    def create?
      new?
    end

    def edit?
      record.programming_course.instructor == user
    end

    def update?
      edit?
    end
  end
end