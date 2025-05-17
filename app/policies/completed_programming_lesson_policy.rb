# Policy for completed programming lessons to check if the user has access to them
class CompletedProgrammingLessonPolicy < ApplicationPolicy
  # Scope for completed programming lessons to only take into account the lessons that the user has completed
  class Scope < ApplicationPolicy::Scope
  end

  def create?
    record.programming_course.enrolled_users.include?(user)
  end
end
