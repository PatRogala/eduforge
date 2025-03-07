class AddSlugToProgrammingCourses < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!
  
  def change
    add_column :programming_courses, :slug, :string
    add_index :programming_courses, :slug, unique: true, algorithm: :concurrently
  end
end
