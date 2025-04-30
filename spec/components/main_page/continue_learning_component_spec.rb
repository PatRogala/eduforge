require "rails_helper"

RSpec.describe MainPage::ContinueLearningComponent, type: :component do
  it "does not render the component for a user without courses" do
    render_inline(described_class.new(user: build(:user)))
    expect(rendered_content).to be_empty
  end

  it "does not render the component for a guest" do
    render_inline(described_class.new(user: nil))
    expect(rendered_content).to be_empty
  end

  it "renders the component for a user with courses" do
    user = create(:user)
    course = create(:programming_course, instructor: user)
    create(:programming_course_enrollment, user: user, programming_course: course)
    render_inline(described_class.new(user: user))
    expect(rendered_content).not_to be_empty
  end
end
