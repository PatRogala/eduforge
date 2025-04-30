# Lookbook preview for Instructor::CourseCreationPanelComponent
class CourseCreationPanelComponentPreview < ViewComponent::Preview
  def default
    render(Instructor::CourseCreationPanelComponent.new)
  end
end
