class AddUserGeneratedToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :user_generated, :boolean, default: false
  end
end
