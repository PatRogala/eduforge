require "rails_helper"

RSpec.describe Flash::FlashMessageComponent, type: :component do
  it "renders the component if any message given" do
    render_inline(described_class.new(notice: "Some notice", alert: "Some alert"))
    expect(rendered_content).not_to be_empty
  end

  it "does not render component with no flash messages" do
    render_inline(described_class.new(notice: nil, alert: nil))
    expect(rendered_content).to be_empty
  end
end
