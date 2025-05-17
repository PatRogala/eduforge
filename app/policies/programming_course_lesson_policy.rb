# Policy for programming course lessons to check if the user has access to them
class ProgrammingCourseLessonPolicy < ApplicationPolicy
  # Scope for programming course lessons to only take into account the lessons that the user has access to
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.joins(programming_course_chapter: { programming_course: :programming_course_enrollments })
           .where(programming_course_chapters: { programming_courses:
                                                { programming_course_enrollments: { user: user } } })
    end
  end

  def show?
    record.programming_course.enrolled_users.include?(user)
  end
end
