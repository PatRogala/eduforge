module Layout
  # Dropdown menu for the user avatar in the header
  class HeaderDropdownComponent < ViewComponent::Base
    attr_reader :current_user

    # @param current_user [User] The user for whom the dropdown is rendered.
    def initialize(current_user:)
      super
      @current_user = current_user
    end
  end
end
