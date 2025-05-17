class DeleteUnusedIndex < ActiveRecord::Migration[8.0]
  def change
    remove_index :completed_programming_lessons, name: "index_completed_programming_lessons_on_user_id"
  end
end
