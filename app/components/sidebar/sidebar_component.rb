module Sidebar
  # Left sidebar of the application, with navigation links
  class SidebarComponent < ViewComponent::Base
    attr_reader :current_user

    def initialize(current_user:)
      super
      @current_user = current_user
    end

    def navigation_links
      @public_links
    end

    def before_render
      @public_links = [
        {
          title: "Dashboard",
          path: root_path,
          icon: "layout-dashboard"
        }
      ]
    end
  end
end
