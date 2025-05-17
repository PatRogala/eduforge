module MainPage
  # Component for displaying user welcome message on the main page only for logged in users
  class UserWelcomeComponent < ViewComponent::Base
    attr_reader :user

    def initialize(user:)
      super
      @user = user
    end

    def render?
      user.present?
    end

    private

    def user_display_name
      user.email.split("@").first
    end
  end
end
