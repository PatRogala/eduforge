# Create programming tasks table
class CreateProgrammingTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :programming_tasks do |t|
      t.string :language, null: false
      t.text :initial_code, null: false
      t.text :solution_code, null: false
      t.jsonb :test_cases, null: false, default: {}
      t.jsonb :hints, null: false, default: {}
      t.string :difficulty, null: false
      t.references :programming_course_lesson, null: false, foreign_key: true

      t.timestamps
    end

    add_index :programming_tasks, :difficulty
  end
end
