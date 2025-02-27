require "rails_helper"

RSpec.describe Sidebar::SidebarComponent, type: :component do
  it "renders the component" do
    render_inline(described_class.new(current_user: nil))
    expect(rendered_content).not_to be_empty
  end

  it "renders only public links to non logged in user" do
    component = described_class.new(current_user: nil)
    render_inline(component)
    expect(component.navigation_links.count).to eq(1)
  end
end
