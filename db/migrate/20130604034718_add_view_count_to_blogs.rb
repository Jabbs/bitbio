class AddViewCountToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :view_count, :integer, default: 0
  end
end
