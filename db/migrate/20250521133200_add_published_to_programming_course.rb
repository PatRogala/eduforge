class AddPublishedToProgrammingCourse < ActiveRecord::Migration[8.0]
  def change
    add_column :programming_courses, :published, :boolean, default: false
  end
end
