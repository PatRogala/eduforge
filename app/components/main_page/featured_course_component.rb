module MainPage
  # Featured course on the main page, changed every day
  class FeaturedCourseComponent < ViewComponent::Base
    def render?
      featured_course.present?
    end

    private

    def featured_course
      Rails.cache.fetch("featured_course", expires_in: 1.day) do
        ProgrammingCourse.order("RANDOM()").first
      end
    end
  end
end
