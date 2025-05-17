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
          path: instructor_programming_courses_path,
          icon: "square-plus"
        }
      ]

      @logged_in_links = [
        {
          title: ".my_courses",
          path: my_courses_path,
          icon: "book-open"
        }
      ]
    end

    private

    def active_link_class(path)
      current_path = request.path
      active_classes = "bg-bg-tertiary text-accent font-medium"
      inactive_classes = "text-text-secondary hover:bg-bg-hover hover:text-text-primary"
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

    def render_link(link)
      link_to link[:path], class: "flex items-center px-3 rounded-lg py-2.5 transition-colors duration-150 #{active_link_class(link[:path])}" do
        concat(content_tag(:span, lucide_icon(link[:icon], class: "w-5 h-5"), class: "mr-3 flex-shrink-0", "data-sidebar-target": "button"))
        concat(content_tag(:span, t(link[:title]), class: "flex-1 whitespace-nowrap transition-opacity duration-300", "data-sidebar-target": "content"))
      end
    end
  end
end
