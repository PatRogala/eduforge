require "rails_helper"

RSpec.describe ApplicationPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:record) { nil }

  permissions :index? do
    it "denies index by default" do
      expect(subject).not_to permit(user, record)
    end
  end

  permissions :show? do
    it "denies show by default" do
      expect(subject).not_to permit(user, record)
    end
  end

  permissions :create? do
    it "denies create by default" do
      expect(subject).not_to permit(user, record)
    end
  end

  permissions :update? do
    it "denies update by default" do
      expect(subject).not_to permit(user, record)
    end
  end

  permissions :destroy? do
    it "denies destroy by default" do
      expect(subject).not_to permit(user, record)
    end
  end

  describe "Scope" do
    it "raises an error" do
      expect { subject::Scope.new(user, ProgrammingCourse).resolve }.to raise_error(NoMethodError)
    end
  end
end
