module Layout
  # Header on the top of the page for main layout and navigation
  class HeaderComponent < ViewComponent::Base
    attr_reader :current_user

    # @param current_user [User, nil] The user currently logged in, or nil if no user is authenticated.
    def initialize(current_user:)
      super
      @current_user = current_user
    end

    private

    # @return [Boolean] Whether the current user is present
    def logged_in?
      @current_user.present?
    end

    # @return [String, nil] The avatar attribute of the current user, or nil if not set.
    def user_avatar
      @current_user.avatar
    end
  end
end
