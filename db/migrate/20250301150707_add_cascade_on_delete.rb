class AddCascadeOnDelete < ActiveRecord::Migration[8.0]
  def change
    safety_assured do
      remove_foreign_key :user_roles, :users
      remove_foreign_key :user_roles, :roles

      add_foreign_key :user_roles, :users, on_delete: :cascade
      add_foreign_key :user_roles, :roles, on_delete: :cascade
    end
  end
end
