# Lookbook preview for MainPage::ContinueLearningComponent
class ContinueLearningComponentPreview < ViewComponent::Preview
  def user_with_courses
    user = User.first
    render(MainPage::ContinueLearningComponent.new(user: user))
  end
end
