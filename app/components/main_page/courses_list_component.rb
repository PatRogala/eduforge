module MainPage
  # List of random 6 courses on the main page, changed every day
  class CoursesListComponent < ViewComponent::Base
    def render?
      courses.any?
    end

    private

    def courses
      Rails.cache.fetch("main_page_programming_courses", expires_in: 1.day) do
        ProgrammingCourse.with_rich_text_description
                         .order("RANDOM()")
                         .limit(6)
      end
    end
  end
end
