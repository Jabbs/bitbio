class AddContinentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :continent, :string
    add_index :users, :continent
  end
end
