module Layout
  # Dropdown menu for the user avatar in the header
  class HeaderDropdownComponent < ViewComponent::Base
    attr_reader :current_user

    def initialize(current_user:)
      super
      @current_user = current_user
    end
  end
end
