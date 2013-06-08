class ChangeCommentsToPolymorphic < ActiveRecord::Migration
  def up
    remove_column :comments, :project_id
    add_column :comments, :commentable_type, :string
    add_column :comments, :commentable_id, :integer
    add_index :comments, :commentable_type
    add_index :comments, :commentable_id
  end
  
  def down
    add_column :comments, :project_id, :integer
    remove_column :comments, :commentable_type
    remove_column :comments, :commentable_id
    remove_index :comments, :commentable_type
    remove_index :comments, :commentable_id
  end
end
