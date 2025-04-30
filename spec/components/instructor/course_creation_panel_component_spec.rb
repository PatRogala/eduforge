require "rails_helper"

RSpec.describe Instructor::CourseCreationPanelComponent, type: :component do
  it "renders the component" do
    render_inline(described_class.new)

    expect(rendered_content).not_to be_empty
  end
end
