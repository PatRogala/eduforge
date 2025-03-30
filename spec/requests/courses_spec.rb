require "rails_helper"

RSpec.describe "Courses" do
  let(:user) { create(:user) }
  let!(:course) { create(:programming_course, instructor: user) }

  describe "GET /courses" do
    it "returns a successful response" do
      get courses_path
      expect(response).to have_http_status(:success)
    end

    it "displays a list of courses" do
      get courses_path
      expect(response.body).to include(course.title)
    end
  end
end
