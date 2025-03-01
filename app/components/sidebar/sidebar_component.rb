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
      return @non_logged_in_links if current_user.nil?

      @logged_in_links if current_user.present?
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

      @logged_in_links = [
        {
          title: ".sign_out",
          path: destroy_user_session_path,
          icon: "log-out"
        }
      ]
    end
  end
end
