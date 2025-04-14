class CreateProgrammingCourseChapters < ActiveRecord::Migration[8.0]
  def change
    create_table :programming_course_chapters do |t|
      t.string :title, null: false
      t.references :programming_course, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end