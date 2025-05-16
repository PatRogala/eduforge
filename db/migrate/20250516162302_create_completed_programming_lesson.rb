class CreateCompletedProgrammingLesson < ActiveRecord::Migration[8.0]
  def change
    create_table :completed_programming_lessons do |t|
      t.references :user, null: false, foreign_key: true
      t.references :programming_course_lesson, null: false, foreign_key: true
      t.timestamps
    end

    add_index :completed_programming_lessons, [:user_id, :programming_course_lesson_id], unique: true
  end
end
