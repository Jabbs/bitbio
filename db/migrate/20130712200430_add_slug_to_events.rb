class AddSlugToEvents < ActiveRecord::Migration
  def change
    add_column :events, :slug, :string
    add_column :events, :bitly_url, :string
    add_column :events, :view_count, :string
    add_column :events, :user_id, :integer
    add_index :events, :slug
    add_index :events, :user_id
  end
end
