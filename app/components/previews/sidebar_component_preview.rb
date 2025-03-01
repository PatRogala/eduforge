# Lookbook preview for Sidebar::SidebarComponent
class SidebarComponentPreview < ViewComponent::Preview
  def guest_user
    render(Sidebar::SidebarComponent.new(current_user: nil))
  end

  def logged_in_user
    render(Sidebar::SidebarComponent.new(current_user: User.new))
  end
end
