require "rails_helper"

RSpec.describe MainPage::UserWelcomeComponent, type: :component do
  it "renders the component for a user" do
    render_inline(described_class.new(user: build(:user)))
    expect(rendered_content).not_to be_empty
  end

  it "does not render the component for a guest" do
    render_inline(described_class.new(user: nil))
    expect(rendered_content).to be_empty
  end
end
