require "rails_helper"

RSpec.describe MainPage::CoursesListComponent, type: :component do
  let(:user) { create(:user) }
  let(:course) { create(:programming_course, instructor: user) }

  before do
    allow(Rails.cache).to receive(:fetch).with("main_page_programming_courses", expires_in: 1.day).and_return([course])
    allow(Rails.cache).to receive(:fetch).with("programming_course_#{course.id}_approximate_duration_in_hours",
                                               expires_in: 1.day).and_return(1.0)
  end

  it "renders the component when courses are available" do
    render_inline(described_class.new)
    expect(rendered_content).not_to be_empty
  end

  it "does not render when no courses are available" do
    allow(Rails.cache).to receive(:fetch).with("main_page_programming_courses", expires_in: 1.day).and_return([])
    render_inline(described_class.new)
    expect(rendered_content).to be_empty
  end
end
