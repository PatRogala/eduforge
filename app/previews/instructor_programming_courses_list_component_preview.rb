# Lookbook preview for Instructor::ProgrammingCoursesListComponent
class InstructorProgrammingCoursesListComponentPreview < ViewComponent::Preview
  def no_courses
    render(Instructor::ProgrammingCoursesListComponent.new(courses: []))
  end

  def with_courses
    render(Instructor::ProgrammingCoursesListComponent.new(courses: [
                                                             ProgrammingCourse.first
                                                           ]))
  end
end
