module Instructor
  # Authorization for ProgrammingCourse as an instructor
  class ProgrammingCoursePolicy < ApplicationPolicy
    def index?
      user.instructor?
    end

    def show?
      user.instructor?
    end

    def create?
      user.instructor?
    end

    def update?
      user.instructor?
    end

    def publish?
      record.instructor == user
    end

    # Only allow instructor to manage courses created by themself
    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.unscoped.where(instructor: user).friendly.order(created_at: :desc)
      end
    end
  end
end
