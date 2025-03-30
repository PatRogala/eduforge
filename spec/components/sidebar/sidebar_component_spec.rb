require "rails_helper"

RSpec.describe Sidebar::SidebarComponent, type: :component do
  it "renders the component" do
    render_inline(described_class.new(current_user: nil))
    expect(rendered_content).not_to be_empty
  end
end
