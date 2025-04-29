module Layout
  # Header on the top of the page for main layout and navigation
  class HeaderComponent < ViewComponent::Base
    def initialize(current_user:)
      super
      @current_user = current_user
    end

    private

    def logged_in?
      @current_user.present?
    end

    def user_avatar
      @current_user.avatar
    end
  end
end
