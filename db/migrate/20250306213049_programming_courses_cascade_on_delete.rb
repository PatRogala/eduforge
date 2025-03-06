class ProgrammingCoursesCascadeOnDelete < ActiveRecord::Migration[8.0]
  def change
    safety_assured do
      remove_foreign_key :programming_courses, column: :instructor_id
      add_foreign_key :programming_courses, :users, column: :instructor_id, on_delete: :cascade
    end
  end
end
