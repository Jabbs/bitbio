class ChangeDescriptionToBioInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :description, :bio
  end
end
