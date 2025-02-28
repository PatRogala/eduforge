# Lookbook preview for Sidebar::SidebarComponent
class SidebarComponentPreview < ViewComponent::Preview
  def default
    render(Sidebar::SidebarComponent.new(current_user: nil))
  end
end
