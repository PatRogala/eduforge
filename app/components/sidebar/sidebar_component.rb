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

    def bottom_links
      @non_logged_in_links
    end

    def before_render
      @public_links = [
        {
          title: ".dashboard",
          path: root_path,
          icon: "layout-dashboard"
        }
      ]

      @non_logged_in_links = [
        {
          title: ".sign_in",
          path: new_user_session_path,
          icon: "log-in"
        }
      ]
    end
  end
end
