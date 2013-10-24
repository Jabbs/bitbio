class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.string :organization
      t.string :department
      t.string :country
      t.string :phone
      t.string :type
      t.text :notes
      t.string :title

      t.timestamps
    end
    add_index :leads, :email
    add_index :leads, :last_name
    add_index :leads, :country
  end
end
