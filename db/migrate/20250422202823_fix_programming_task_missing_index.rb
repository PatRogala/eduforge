class FixProgrammingTaskMissingIndex < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_index :programming_tasks, :programming_course_lesson_id, unique: true, name: 'unique_programming_task_per_lesson', algorithm: :concurrently

    remove_index :programming_tasks, name: :index_programming_tasks_on_programming_course_lesson_id
  end
end
