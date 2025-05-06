module Course
  # Component for displaying a course information
  class CourseShowComponent < ViewComponent::Base
    attr_reader :course

    delegate :approximate_duration_in_hours, to: :course
    delegate :current_user, to: :helpers
    delegate :count, to: :chapters, prefix: true

    def initialize(course:)
      super
      @course = course
    end

    def students_count
      course.enrolled_users.count
    end

    def lessons_count
      course.programming_course_lessons.count
    end

    def chapters
      course.programming_course_chapters
    end
  end
end
