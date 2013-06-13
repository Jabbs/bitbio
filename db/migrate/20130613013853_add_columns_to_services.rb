class AddColumnsToServices < ActiveRecord::Migration
  def change
    add_column :services, :slug, :string
    add_column :services, :view_count, :integer, default: 0
    add_column :services, :bitly_url, :string
    add_column :services, :visability, :string, default: "public"
    add_column :services, :expiration_date, :string
    add_column :services, :searchable, :boolean, default: true
    add_column :services, :active, :boolean, default: true
    add_index :services, :slug
    add_index :services, :visability
    add_index :services, :searchable
    add_index :services, :expiration_date
  end
end
