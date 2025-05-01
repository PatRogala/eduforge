module Instructor
  # List of programming courses for instructors to manage
  class ProgrammingCoursesListComponent < ViewComponent::Base
    attr_reader :courses

    def initialize(courses:)
      super
      @courses = courses
    end

    private

    def total_courses
      @courses.count
    end

    def total_students
      @courses.sum(&:enrolled_users_count)
    end

    def average_rating
      0 # TODO: Implement this
    end

    def total_revenue
      0 # TODO: Implement this
    end
  end
end
