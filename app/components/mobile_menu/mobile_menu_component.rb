module MobileMenu
  # Mobile menu of the application, with navigation links
  class MobileMenuComponent < ViewComponent::Base
    attr_reader :current_user

    def initialize(current_user:)
      super
      @current_user = current_user
    end

    def navigation_links
      links_to_render = []
      links_to_render += @public_links
      links_to_render += @instructor_links if current_user&.instructor?

      links_to_render
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

      @instructor_links = [
        {
          title: ".created_courses",
          path: new_instructor_course_path,
          icon: "book-plus"
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
          icon: "log-out",
          type: :delete
        }
      ]
    end
  end
end