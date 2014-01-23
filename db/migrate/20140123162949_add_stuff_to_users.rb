class AddStuffToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title, :string
    add_column :users, :tw_url, :string
    add_column :users, :li_url, :string
    add_column :users, :mend_url, :string
    add_column :users, :fb_url, :string
    add_column :users, :website, :string
    add_column :users, :interest_description, :text
  end
end
