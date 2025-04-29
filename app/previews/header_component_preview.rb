# Lookbook preview for Layout::HeaderComponent
class HeaderComponentPreview < ViewComponent::Preview
  def logged_in_user
    render(Layout::HeaderComponent.new(current_user: User.new))
  end

  def logged_out_user
    render(Layout::HeaderComponent.new(current_user: nil))
  end
end
