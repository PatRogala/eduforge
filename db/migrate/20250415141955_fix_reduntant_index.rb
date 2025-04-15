class FixReduntantIndex < ActiveRecord::Migration[8.0]
  def change
    # RedundantIndexChecker fail ProgrammingCourseEnrollment index_programming_course_enrollments_on_user_id index is redundant as idx_on_user_id_programming_course_id_dcb9194487 covers it
    remove_index :programming_course_enrollments, :user_id
  end
end
