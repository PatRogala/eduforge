class RemoveIndexFriendlyIdSlugsOnSlugAndSluggableType < ActiveRecord::Migration[8.0]
  def change
    remove_index :friendly_id_slugs, name: :index_friendly_id_slugs_on_slug_and_sluggable_type
  end
end
