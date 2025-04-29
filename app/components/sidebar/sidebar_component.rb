module Sidebar
  # Left sidebar of the application, with navigation links
  class SidebarComponent < ViewComponent::Base
    attr_reader :current_user, :public_links, :instructor_links, :logged_in_links

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

      @logged_in_links = [
        {
          title: ".my_courses",
          path: my_courses_courses_path,
          icon: "book-open"
        }
      ]
    end

    private

    def active_link_class(path)
      current_path = request.path
      active_classes = "bg-indigo-50 text-indigo-600"
      inactive_classes = "hover:bg-gray-100 text-gray-700"
      current_path == path ? active_classes : inactive_classes
    end

    def instructor?
      current_user&.instructor?
    end

    def admin?
      current_user&.admin?
    end

    def logged_in?
      current_user.present?
    end
  end
end
