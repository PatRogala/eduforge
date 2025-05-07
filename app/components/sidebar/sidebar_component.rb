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
          path: my_courses_path,
          icon: "book-open"
        }
      ]
    end

    private

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
      path = link[:path]
      is_active = current_page?(path)

      base_classes = "flex items-center px-3 py-2 rounded-sm text-sm font-medium transition-colors duration-150 ease-in-out"

      state_classes = if is_active
                        "bg-blue-100 text-blue-800 font-semibold shadow-[inset_0_1px_2px_rgba(0,0,0,0.06)]"
                      else
                        "text-blue-700 hover:bg-blue-100 hover:text-blue-900"
                      end

      icon_color_class = is_active ? "text-blue-800" : "text-blue-600"

      link_to path, class: "#{base_classes} #{state_classes}" do
        icon_html = lucide_icon(link[:icon], class: "w-5 h-5 #{icon_color_class}")
        concat(content_tag(:span, icon_html, class: "mr-3 flex-shrink-0", "data-sidebar-target": "button"))
        concat(content_tag(:span, t(link[:title]), class: "flex-1 whitespace-nowrap transition-opacity duration-300", "data-sidebar-target": "content"))
      end
    end
  end
end
