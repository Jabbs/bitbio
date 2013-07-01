class AddSlugToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :slug, :string
    add_index :facilities, :slug
  end
end
