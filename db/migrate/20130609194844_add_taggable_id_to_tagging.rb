class AddTaggableIdToTagging < ActiveRecord::Migration
  def up
    add_column :taggings, :taggable_id, :integer
    add_column :taggings, :taggable_type, :string
    remove_column :taggings, :project_id
    add_index :taggings, [:taggable_id, :taggable_type]
  end
  
  def down
    add_column :taggings, :project_id, :integer
    remove_column :taggings, :taggable_id
    remove_column :taggings, :taggable_type
  end
end
