class AddBitlyUrlToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :bitly_url, :string
  end
end
