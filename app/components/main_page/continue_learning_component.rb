module MainPage
  # List of 3 courses that the user is enrolled in
  class ContinueLearningComponent < ViewComponent::Base
    attr_reader :user

    def initialize(user:)
      super
      @user = user
    end

    def render?
      user.present? && courses.any?
    end

    def courses
      @courses ||= user.enrolled_programming_courses.includes(:programming_course_lessons).limit(3)
    end
  end
end
