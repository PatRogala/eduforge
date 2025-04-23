class ChangeCascade < ActiveRecord::Migration[8.0]
  def change
    safety_assured do
      remove_foreign_key :programming_tasks, :programming_course_lessons
      add_foreign_key :programming_tasks, :programming_course_lessons, on_delete: :cascade, unique: true
    end
  end
end
