# Lookbook preview for Layout::HeaderComponent
class HeaderComponentPreview < ViewComponent::Preview
  # Simulates the header as it appears when a user is authenticated by providing the first user in the database as `current_user`.
  def logged_in_user
    render(Layout::HeaderComponent.new(current_user: User.first))
  end

  # Displays the Layout::HeaderComponent with no current user to simulate the logged-out state.
  def logged_out_user
    render(Layout::HeaderComponent.new(current_user: nil))
  end
end
