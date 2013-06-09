class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :attachable_type
      t.integer :attachable_id

      t.timestamps
    end
    add_index :attachments, [:attachable_type, :attachable_id]
  end
end
