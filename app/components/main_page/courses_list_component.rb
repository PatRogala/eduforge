module MainPage
  # List of random 6 courses on the main page, changed every day
  class CoursesListComponent < ViewComponent::Base
    ##
    # Determines if the component should be rendered by checking for available courses.
    #
    # @return [Boolean] True if at least one course exists; otherwise, false.
    def render?
      courses.any?
    end

    private

    ##
    # Retrieves a cached list of six random programming courses with rich text descriptions.
    #
    # Attempts to fetch the courses from the Rails cache using the "main_page_programming_courses" key with a 1-day expiration.
    # If the cache is empty or expired, it queries the database for courses that have rich text descriptions, orders them randomly,
    # and limits the result to six entries.
    #
    # @return [ActiveRecord::Relation] A collection of programming course records.
    def courses
      Rails.cache.fetch("main_page_programming_courses", expires_in: 1.day) do
        ProgrammingCourse.with_rich_text_description
                         .order("RANDOM()")
                         .limit(6)
      end
    end
  end
end
