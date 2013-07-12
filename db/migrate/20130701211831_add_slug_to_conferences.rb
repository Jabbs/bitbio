class AddSlugToEvents < ActiveRecord::Migration
  def change
    add_column :conferences, :slug, :string
    add_column :conferences, :bitly_url, :string
    add_column :conferences, :view_count, :integer, default: 0
    add_column :conferences, :user_id, :integer
    add_index :conferences, :slug
    add_index :conferences, :user_id
  end
end
