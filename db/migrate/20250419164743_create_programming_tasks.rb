# Create programming tasks table
class CreateProgrammingTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :programming_tasks do |t|
      t.text :initial_code, null: false
      t.text :solution_code, null: false
      t.jsonb :test_cases, null: false, default: []
      t.text :hints, array: true, default: []
      t.string :difficulty_level, null: false
      t.integer :points, null: false, default: 0
      t.references :programming_course_lesson, null: false, foreign_key: true

      t.timestamps
    end

    add_index :programming_tasks, :difficulty_level
    add_index :programming_tasks, :points
  end
end
