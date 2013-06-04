class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :body
      t.integer :user_id

      t.timestamps
    end
    add_index :blogs, :title
    add_index :blogs, :user_id
  end
end
