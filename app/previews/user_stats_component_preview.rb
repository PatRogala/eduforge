# Lookbook preview for MainPage::UserStatsComponent
class UserStatsComponentPreview < ViewComponent::Preview
  def user_stats
    user = User.new
    render(MainPage::UserStatsComponent.new(user: user))
  end
end
