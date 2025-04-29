require "rails_helper"

RSpec.describe Layout::HeaderComponent, type: :component do
  it "renders the component when user is logged in" do
    render_inline(described_class.new(current_user: User.new))
    expect(rendered_content).not_to be_empty
  end

  it "renders the component when user is logged out" do
    render_inline(described_class.new(current_user: nil))
    expect(rendered_content).not_to be_empty
  end
end
