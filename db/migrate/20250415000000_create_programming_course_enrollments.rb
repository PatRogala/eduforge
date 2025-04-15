class CreateProgrammingCourseEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :programming_course_enrollments do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :programming_course, null: false, foreign_key: { on_delete: :cascade }
      t.datetime :enrolled_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end

    add_index :programming_course_enrollments, [:user_id, :programming_course_id], unique: true
  end
end
