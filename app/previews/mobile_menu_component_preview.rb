# Lookbook preview for MobileMenu::MobileMenuComponent
class MobileMenuComponentPreview < ViewComponent::Preview
  def guest_user
    render(MobileMenu::MobileMenuComponent.new(current_user: nil))
  end

  def logged_in_user
    render(MobileMenu::MobileMenuComponent.new(current_user: User.new))
  end
end