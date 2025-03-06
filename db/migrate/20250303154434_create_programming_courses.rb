class CreateProgrammingCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :programming_courses do |t|
      t.string :title, null: false, index: { unique: true }
      t.references :instructor, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
