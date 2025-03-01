class CreateRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :roles do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end

    Role.create!(name: 'Admin', id: 1)
    Role.create!(name: 'Instructor', id: 2)
  end
end
