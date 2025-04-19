module Sidebar
  # Left sidebar of the application, with navigation links
  class SidebarComponent < ViewComponent::Base
    attr_reader :current_user, :public_links, :instructor_links, :non_logged_in_links, :logged_in_links

    def initialize(current_user:)
      super
      @current_user = current_user
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
          title: ".my_courses",
          path: my_courses_programming_courses_path,
          icon: "book-open"
        }
      ]
    end

    private

    def active_link_class(path)
      current_path = request.path
      active_classes = "bg-blue-100 text-blue-700 font-medium"
      inactive_classes = "text-gray-600 hover:bg-gray-100 hover:text-gray-900"
      current_path == path ? active_classes : inactive_classes
    end

    def instructor?
      current_user&.instructor?
    end

    def admin?
      current_user&.admin?
    end
  end
end
