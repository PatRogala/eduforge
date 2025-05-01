require "rails_helper"

RSpec.describe Instructor::ProgrammingCoursesListComponent, type: :component do
  it "renders the component" do
    render_inline(described_class.new(courses: []))

    expect(rendered_content).not_to be_empty
  end
end
