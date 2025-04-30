# Lookbook preview for MainPage::UserWelcomeComponent
class UserWelcomeComponentPreview < ViewComponent::Preview
  def default
    user = User.new(email: "patryk@eduforge.pl")
    render(MainPage::UserWelcomeComponent.new(user: user))
  end
end
