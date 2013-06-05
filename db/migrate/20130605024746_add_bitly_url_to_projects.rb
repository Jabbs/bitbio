class AddBitlyUrlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :bitly_url, :string
  end
end
