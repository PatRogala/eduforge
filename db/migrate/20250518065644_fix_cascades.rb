class FixCascades < ActiveRecord::Migration[8.0]
  def change
    safety_assured do
      remove_foreign_key :completed_programming_lessons, :users
      add_foreign_key :completed_programming_lessons, :users, on_delete: :cascade

      remove_foreign_key :completed_programming_lessons, :programming_course_lessons
      add_foreign_key :completed_programming_lessons, :programming_course_lessons, on_delete: :cascade
    end
  end
end
