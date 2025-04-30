# Lookbook preview for MainPage::ContinueLearningComponent
class ContinueLearningComponentPreview < ViewComponent::Preview
  def default
    user = User.first
    render(MainPage::ContinueLearningComponent.new(user: user))
  end
end
