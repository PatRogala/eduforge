module MainPage
  # Component for displaying user stats on the main page only for logged in users
  class UserStatsComponent < ViewComponent::Base
    attr_reader :user

    def initialize(user:)
      super
      @user = user
    end

    def render?
      user.present?
    end

    private

    def completed_courses_count
      0 # TODO: Implement this
    end

    def hours_learned_count
      0 # TODO: Implement this
    end

    def certificates_earned_count
      0 # TODO: Implement this
    end

    def current_streak_count
      0 # TODO: Implement this
    end
  end
end
