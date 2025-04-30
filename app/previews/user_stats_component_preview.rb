# Lookbook preview for MainPage::UserStatsComponent
class UserStatsComponentPreview < ViewComponent::Preview
  def default
    user = User.new
    render(MainPage::UserStatsComponent.new(user: user))
  end
end
